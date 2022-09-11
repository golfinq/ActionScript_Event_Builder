import argparse
import re
from pathlib import Path

from jinja2 import Template

from read_data import *
from utils.structs import (
    ActionScriptTemplate,
    ASClassConst,
    ASClassMethod,
    ASClassPropList
)
from utils.templates import asm_event_template, method_template


class ActionScriptMaker:
    def __init__(self, in_path, include_air) -> None:
        self.file_path = in_path
        self.include_air = include_air
        self._make_sig()
        self._make_props()
        self._make_methods()
        self._make_consts()
        self._make_connects()
        self._make_constructor()
        self._make_import()

        self.to_string_format = get_string_format(self.file_path)

    def _make_sig(self):
        # Get the signatures from the cache
        self.class_sig = get_class_sig(self.file_path)
        self.inher_sig = get_inherit_sig(self.file_path)
        self.class_name = self.inher_sig[0]
        self.class_package = (
            "" if is_top_level(self.file_path) else get_class_package(self.file_path)
        )
        self.doc_url = str(PurePosixPath(self.file_path)).replace(
            "doc_trunk/doc_pages/",
            "https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/",
        )

    def _make_props(self):
        # Get the Class Properties from the cache
        self.class_props = ASClassPropList()
        for prop_def in get_class_props(self.file_path):
            self.class_props.add_property(*prop_def)

    def _make_methods(self):
        # Get Methods from the cache
        self.class_methods = [
            ASClassMethod(*meth_def) for meth_def in get_class_methods(self.file_path)
        ]

    def _make_consts(self):
        # Find and Parse Class Constants
        self.class_constants = [
            ASClassConst(*const_def) for const_def in get_class_consts(self.file_path)
        ]

    def _make_connects(self):
        # Attach code pieces from cached parsed detail sections to constants and methods
        class_details = get_class_details(self.file_path)

        if not self.include_air:
            # Only include stuff that wasn't marked as AIR-only
            class_details = {
                code_type: {
                    code_name: code[0]
                    for code_name, code in code_info.items()
                    if not code[1]
                }
                for code_type, code_info in class_details.items()
            }

        code_connect = {
            const.name: class_details["constant"][const.name]
            for const in self.class_constants
        }

        for meth in self.class_methods:
            code_connect[meth.name] = class_details["method"][meth.name]
        self.code_connect = code_connect

    def _make_constructor(self):
        """
        The constructor is one of the more complicated parts of this process
        as we need to identify which properties correspond to which input arguments
        This is done by matching variable names and types;
        then matching types and contains the first letter. Any input argument
        which was not identified with a property is assumed to be an input to the super function
        """
        self.con_code = get_constructor(self.file_path)
        self.con_args = get_constructor_args(self.file_path)

        # Round 1 - Matching names and types
        eaten_cons = {
            con_arg_obj.name
            for con_arg_i, con_arg_obj in enumerate(self.con_args)
            if self.class_props.connect(con_arg_i, con_arg_obj, 0)
        }

        # Round 2 - Only matching types and contains the first letter
        for con_arg_i, con_arg_obj in enumerate(self.con_args):
            if con_arg_obj.name in eaten_cons:
                continue
            if self.class_props.connect(con_arg_i, con_arg_obj, 1):
                eaten_cons.add(con_arg_obj.name)

        # All other constructor arguments are assumed to go into super
        self.con_super_args = [
            con_arg_obj
            for con_arg_obj in self.con_args
            if con_arg_obj.name not in eaten_cons
        ]

    def _make_import(self):
        # Identify any imports from all the types which have
        # been parsed which would need an import

        self.class_imports = set()

        for prop_set in [self.class_props.get_properties(), self.con_args]:
            for i_obj in prop_set:
                im_path = get_import_path(self.file_path, i_obj.type)
                if im_path is not None:
                    self.class_imports.add(im_path)

    def __str__(self):
        return (
            "ActionScriptMaker("
            f"Construct Code={self.con_code},"
            f"Construct Args={self.con_args},"
            f"Inheritance={self.inher_sig}, "
            f"Signature='{self.class_sig}', "
            f"Properties={self.class_props}, "
            f"Methods={self.class_methods}, "
            f"Constants={self.class_constants}, "
            f"Connections={self.code_connect})"
        )


class ASMKnownFN:
    # Due to the somewhat simple nature of toString() and clone()
    # We can mostly automatically create these, because we don't have any model of
    # parent objects, generate generic arguments and then edit in the manual step
    fn_full_temp = Template(
        """

        // {{ temp.method_desc }}
        {{ temp.method_con }}
        {
            {{ temp.method_body }}
        }"""
    )

    def __init__(self, method: ASClassMethod, maker: ActionScriptMaker):
        self.method = method
        self.maker = maker

        self.method_desc = method.desc
        self.method_con = maker.code_connect[method.name]
        self.method_body = "// Unknown Implementation"
        self.__post_init__()

    def __post_init__(self):
        pass

    def __str__(self):
        return self.fn_full_temp.render(temp=self)


class ASMToString(ASMKnownFN):
    # Roughly make the toString() function

    def __post_init__(self):
        rv_args = [f'"{pa.name}"' for pa in get_parent_args(self.maker.class_name)]
        # Because toString sometimes has a description of the function output in a nice parsable format
        # we can use that instead of guessing based on class properties
        largl = [
            xx.name.strip()
            for xx in self.maker.class_props.get_properties_by_con_order()
        ]
        if (self.maker.to_string_format is not None) and (
            "..." not in self.maker.to_string_format
        ):
            found_args_in_format_str = [
                s_name.strip()
                for s_name, _ in re.findall(r"(\w+)=(\w+)", self.maker.to_string_format)
                if s_name.strip() in largl
            ]
            rv_args.extend(found_args_in_format_str)
        else:
            # The fallback when the string isn't found, just use the properties and hope for the best
            rv_args.extend(f'"{xx}"' for xx in largl)
        args = "," + ",".join(rv_args) if rv_args else ""
        fn_temp = Template('return this.formatToString("{{class_name}}"{{args}});')
        self.method_body = fn_temp.render(class_name=self.maker.class_name, args=args)


class ASMClone(ASMKnownFN):
    # Roughly make the clone() function

    def __post_init__(self):
        args = [f"this.{pa.name}" for pa in get_parent_args(self.maker.class_name)]
        # We already know the constructor arguments -> class properties, so reuse that
        args.extend(
            f"this.{x.name.strip()}"
            for x in self.maker.class_props.get_properties_with_con_order()
        )
        args = ",".join(args)
        fn_temp = Template("return new {{class_name}}({{args}});")
        self.method_body = fn_temp.render(class_name=self.maker.class_name, args=args)


def make_method_str(maker: ActionScriptMaker):
    # There are three methods we know how to roughly build
    # - toString
    # - clone
    # - read-only getters
    # Everything else requires actual knowledge, so implementing a generator here would be slower
    # than just writing the function in either Rust or ActionScript
    method_str = ""
    for method in maker.class_methods:
        # The constructor is already created
        if method.name == maker.class_name:
            continue

        if method.name == "toString":
            meth_make = ASMToString(method, maker)
        elif method.name == "clone":
            meth_make = ASMClone(method, maker)
        else:
            meth_make = ASMKnownFN(method, maker)
        method_str += str(meth_make)

    for c in maker.class_props.get_properties_by_con_order():
        if c.readonly:
            method_str += method_template.render(c=c)

    return method_str


def write_code(maker: ActionScriptMaker):
    # Write the code itself using all the pieces from the soup
    asmt = ActionScriptTemplate()
    asmt.class_sig = maker.class_sig
    asmt.class_parent = maker.inher_sig[1]
    asmt.class_package = maker.class_package
    asmt.doc_url = maker.doc_url

    class_con_lines = []
    for c in maker.class_constants:
        class_con_lines.extend([f"// {c.desc}", f"{maker.code_connect[c.name]};", ""])
    asmt.class_constants = "\n        ".join(class_con_lines)

    class_prop_lines = []
    for c in maker.class_props.get_properties_by_con_order():
        class_prop_lines.extend(
            [
                f"// {c.desc}",
                f"{'private' if c.readonly else 'public'} var {'_' if c.readonly else ''}{c.name}: {c.type};",
                "",
            ]
        )
    asmt.class_properties = "\n        ".join(class_prop_lines)

    asmt.con_def = maker.con_code
    asmt.super_args = ",".join(x.name for x in maker.con_super_args)
    asmt.con_body = "\n            ".join(
        [
            f"this.{'_' if c_arg.readonly else ''}{c_arg.name} = {c_arg.con_arg.name};"
            for c_arg in maker.class_props.get_properties_with_con_order()
        ]
    )
    asmt.methods = make_method_str(maker)
    asmt.imports = "\n    ".join(maker.class_imports)

    return asm_event_template.render(temp=asmt)


def remove_multiple_newlines(in_str):
    return re.sub(
        r"(?:(?:(?:\n)|(?:\r\n))(?:(?:\s{8})|(?:)|(?:\s{4}))[^\S]){3,}", "\n", in_str
    )


def parse_arguments():
    parser = argparse.ArgumentParser(
        description="Make ActionScript Classes based on parsed documentation - roughly"
    )
    parser.add_argument(
        "--ignore", "-i", action="store_true", help="ignore existing files"
    )
    parser.add_argument(
        "--output",
        "-o",
        default="as_gen",
        help="output generated path; Default: `./as_gen`",
    )
    parser.add_argument(
        "--include-air",
        "-a",
        action="store_true",
        help="Include properties and methods marked as AIR-only",
    )
    parser.add_argument(
        "path",
        help="The path of the classes to make, ie x.y.z; searches `./doc_trunk/doc_pages/x/y/z/` for all html files, but will not recursively search",
    )
    return parser.parse_args()


def main():
    args = parse_arguments()
    search_path = None
    for path_ele in args.path.split("."):
        search_path = (
            Path(path_ele) if (search_path is None) else (search_path / path_ele)
        )
    gen_path = Path(args.output)
    gen_path.mkdir(parents=True, exist_ok=True)
    gen_files = [] if args.ignore else [x.stem for x in gen_path.glob("*.as")]

    doc_pages_dir = Path("doc_trunk") / "doc_pages"
    input_files = (doc_pages_dir / search_path).glob("*.html")
    for html_file in input_files:
        class_name = html_file.stem
        if class_name in gen_files:
            continue
        html_doc = html_file.read_text()
        try:
            asm_maker = ActionScriptMaker(html_file, args.include_air)
        except UnknownFileError:
            print("Unknown class associated with ", html_file)
            continue
        (gen_path / f"{class_name}.as").write_text(
            remove_multiple_newlines(write_code(asm_maker).strip())
        )
        print(
            f"Completed {class_name}! Please double check to ensure there are no issues"
        )


if __name__ == "__main__":
    main()
