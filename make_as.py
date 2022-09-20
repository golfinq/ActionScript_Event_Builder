import argparse
import os
import re
from pathlib import Path, PurePosixPath

from jinja2 import Template

from read_data import *
from utils.structs import (ActionScriptTemplate, ASClassConst, ASClassMethod,
                           ASClassPropList)
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
        self.class_parent = self.inher_sig[1]
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
            if const.name in class_details["constant"]
        }

        for meth in self.class_methods:
            if meth.name in class_details["method"]:
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

        if self.class_parent.lower() == "object":
            # This class does not have a super function thus as a final
            # attempt - will only match by types
            for con_arg_i, con_arg_obj in enumerate(self.con_args):
                if con_arg_obj.name in eaten_cons:
                    continue
                if self.class_props.connect(con_arg_i, con_arg_obj, 2):
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

        self.method_desc = clean_comment(method.desc)
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
        rv_args = [pa.name for pa in get_parent_args(self.maker.file_path)]
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
            rv_args.extend(largl)
        args = "," + ",".join(f'"{xx}"' for xx in rv_args) if rv_args else ""
        fn_temp = Template('return this.formatToString("{{class_name}}"{{args}});')
        self.method_body = fn_temp.render(class_name=self.maker.class_name, args=args)


class ASMClone(ASMKnownFN):
    # Roughly make the clone() function

    def __post_init__(self):
        args = [f"this.{pa.name}" for pa in get_parent_args(self.maker.file_path)]
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
    asmt.class_parent = maker.class_parent
    asmt.class_package = maker.class_package
    asmt.doc_url = maker.doc_url

    class_con_lines = []
    for c in maker.class_constants:
        if c.name in maker.code_connect:
            class_con_lines.extend([f"// {clean_comment(c.desc)}", f"{maker.code_connect[c.name]};", ""])
    asmt.class_constants = "\n        ".join(class_con_lines)

    class_prop_lines = []
    for c in maker.class_props.get_properties_by_con_order():
        
        class_prop_lines.extend(
            [
                f"// {clean_comment(c.desc)}",
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

def clean_comment(idesc):
    return re.sub(r"\[(?:read-only|static)\]\s*", "", idesc)

def remove_blank_comments(in_str):
    return re.sub(r"//\s*$","", in_str)

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
        default="output",
        help="output generated path; Default: `./output`",
    )
    parser.add_argument(
        "--build-tree",
        "-b",
        action="store_true",
        help="Put the output files into folders corresponding to thier paths",
    )
    parser.add_argument(
        "--include-air",
        "-a",
        action="store_true",
        help="Include properties and methods marked as AIR-only",
    )
    parser.add_argument(
        "path",
        type=str,
        nargs='+',
        help="A reference to the classes to make, either a classname or a path x.y.z; path searches will not recursively search and classname will make the first enecountered class with that name",
    )
    return parser.parse_args()


def main():
    args = parse_arguments()
    args.path.sort()
    input_files = []
    for ipath in args.path:
        ipath = ipath.strip()
        search_path = (None, None)
        if "." in ipath:
            for path_ele in ipath.split("."):
                search_path = (
                    class_tree[path_ele] if None in search_path else search_path[0][path_ele],
                    path_ele if None in search_path else f"{search_path[1]}.{path_ele}"
                )
            if len(search_path[0].keys()) == 0:
                search_path = (None, search_path[1])
                print("Making single class", search_path[1])
            else:
                print("Making all classes in ", search_path[1])
        else:
            for class_path in class_path_to_file:
                class_name = class_path.split(".").pop()
                if class_name == ipath:
                    search_path = (None, class_path)
                    break

            print("Making single class ", search_path[1])
        ipath_input_files = [class_path_to_file[f"{search_path[1]}.{nested_class}"] for nested_class in search_path[0].keys() if (f"{search_path[1]}.{nested_class}" in class_path_to_file)] if (search_path[0] is not None) else [class_path_to_file[search_path[1]]]
        input_files.extend(ipath_input_files)
    
    gen_path = Path(args.output)
    gen_path.mkdir(parents=True, exist_ok=True)
    gen_files = [] if args.ignore else [x.stem for x in gen_path.glob("*.as")]

    for class_path in input_files:
        class_path = PurePosixPath(class_path)
        class_name = class_path.stem
        print(
            f"Beginning {class_name}..."
        )
        if class_name in gen_files:
            continue
        try:
            asm_maker = ActionScriptMaker(class_path, args.include_air)
        except UnknownFileError:
            print("Unknown class associated with ", class_path)
            continue
        generated_code = remove_multiple_newlines(remove_blank_comments(write_code(asm_maker).strip())) + '\n'
        if args.build_tree:
            out_file = gen_path / class_path.relative_to(PurePosixPath("doc_trunk/doc_pages"))
            out_file.parent.mkdir(parents=True, exist_ok=True)
            (out_file.parent / f"{class_name}.as").write_text(generated_code)
        else:
            (gen_path / f"{class_name}.as").write_text(generated_code)
        print(
            f"Completed {class_name}! Please double check to ensure there are no issues"
        )
        print("")
        print("-------------")
        print("")


if __name__ == "__main__":
    main()
