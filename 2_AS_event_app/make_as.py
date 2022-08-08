import argparse
import re

from jinja2 import Template
from dataclasses import dataclass
from pathlib import Path
from collections import namedtuple
from bs4 import BeautifulSoup

known_imports = {
    "InteractiveObject": "import flash.display.InteractiveObject;",
    "ByteArray": "import flash.utils.ByteArray;",
    "NetStream": "import flash.net.NetStream;",
    "DRMDeviceGroup": "import flash.net.drm.DRMDeviceGroup;",
    "DRMContentData": "import flash.net.drm.DRMContentData;",
    "DRMVoucher": "import flash.net.drm.DRMVoucher;",
    "Dictionary": "import flash.utils.Dictionary;",
    "IIMEClient": "import flash.text.ime.IIMEClient;",
    "BitmapData": "import flash.display.BitmapData;"
}

ASClassMethod = namedtuple("ASClassMethod", ["name", "sig", "desc"])
ASClassConst = namedtuple("ASClassConst", ["name", "sig", "desc"])

class UnknownConstructorError(NameError):
    pass

@dataclass
class ASConArg:
    name: str = ""
    type: str = ""
    default: str = ""
    readonly: bool = False


class ASClassProp:
    def __init__(self, _name, _type, _desc, _readonly):
        self.name = _name
        self.type = _type
        self.desc = _desc
        self.readonly = _readonly

        self.con_arg_order = -1
        self.con_arg = None

    def connect_to_con_arg(self, i_con_arg, con_arg):
        self.con_arg_order = i_con_arg

        con_arg.readonly = self.readonly
        self.con_arg = con_arg

    def __str__(self):
        return f"<ASClassProp name:{self.name}; type:{self.type}; readonly:{self.readonly}; con_arg : [{self.con_arg_order}] = {self.con_arg}>"

class ASClassPropList:
    def __init__(self):
        self.prop_list = dict()

    def add_property(self, _name, _type, _desc, _readonly):
        self.prop_list[_name] = ASClassProp(_name, _type, _desc, _readonly)

    def valid(self):
        return len(self.prop_list.keys()) > 0

    def reset(self):
        self.prop_list = dict()

    def get_property(self, name):
        return self.prop_list[name]

    def get_properties(self):
        return list(self.prop_list.values())

    def _get_max_con_arg(self):
        orders = [x.con_arg_order for x in self.get_properties()]
        if len(orders) == 1:
            return orders[0]
        else:
            return max(*orders)

    def _get_co_prop_helper(self):
        rv = [None for _ in range(self._get_max_con_arg() + 2)]
        frv = []
        for prop in self.get_properties():
            if prop.con_arg_order < 0:
                frv.append(prop)
            else:
                rv[prop.con_arg_order] = prop
        rv = [xx for xx in rv if xx is not None]
        return rv, frv

    def get_properties_by_con_order(self):
        if not self.valid():
            return list()
        rv, frv = self._get_co_prop_helper()
        rv.extend(frv)
        return rv

    def get_properties_with_con_order(self):
        if not self.valid():
            return list()
        rv, _ = self._get_co_prop_helper()
        return rv

    def connect(self, con_arg_index, in_con_arg, stage):
        con_arg_used = False
        for prop_name, prop_obj in self.prop_list.items():
            if stage == 0:
                prop_name_in_con = prop_name.lower().strip() in in_con_arg.name.lower().strip()
            else:
                prop_name_in_con = prop_name[0].lower().strip() in in_con_arg.name.lower().strip()

            prop_type_match = prop_obj.type == in_con_arg.type
            prop_not_used = prop_obj.con_arg_order < 0

            if prop_name_in_con and prop_type_match and prop_not_used:
                prop_obj.connect_to_con_arg(con_arg_index, in_con_arg)
                con_arg_used = True
        return con_arg_used

    def __str__(self):
        return f"<ASClassPropList : {self.get_properties()}>"


asm_event_template = Template("""
package flash.events
{
    {% if temp.imports != "" %}
    {{ temp.imports }}
    {% endif %}
    {{ temp.class_sig }} extends {{ temp.class_parent }}
    {
        {{ temp.class_constants }}

        {{ temp.class_properties }}

        {{ temp.con_def }}
        {
            super({{ temp.super_args }});
            {{ temp.con_body }}
        }
        {{ temp.methods }}
    }
}
""")


@dataclass
class ActionScriptTemplate:
    class_sig: str = ""
    class_parent: str = ""
    class_constants: str = ""
    class_properties: str = ""
    con_def: str = ""
    super_args: str = ""
    con_body: str = ""
    methods: str = ""
    imports: str = ""


class ActionScriptMaker:
    def _make_sig(self):
        # Find and Parse Class Signature and Inheritance
        cth = self.soup.find("table", class_="classHeaderTable")
        cthd = {
            t["class"][0]: t.text
            for t in cth.find_all("td")
            if "class" in t.attrs
        }

        self.class_sig = " ".join(cthd["classSignature"].split())
        self.inher_sig = " ".join(cthd["inheritanceList"].split()).strip().split()
        self.class_name = self.inher_sig[0]

    def _make_props(self):
        # Find and Parse Class Properties
        self.class_props = ASClassPropList()
        prop_table = self.soup.find("table", id="summaryTableProperty")
        for t in prop_table.find_all("tr"):
            if ("class" in t.attrs) and ("hideInheritedProperty" in t.attrs["class"]):
                continue
            sig_col = t.find("td", class_="summaryTableSignatureCol")
            if sig_col is None:
                continue
            name_tag = sig_col.find("a", class_="signatureLink")
            desc_tag = " ".join(sig_col.select_one(".summaryTableDescription").text.strip().split())
            self.class_props.add_property(
                name_tag.text,
                name_tag.find_next_sibling("a").text,
                desc_tag,
                "[read-only]" in desc_tag
            )

    def _make_methods(self):
        # Find and Parse Class Methods
        self.class_methods = []
        method_table = self.soup.find("table", id="summaryTableMethod")
        for t in method_table.find_all("tr"):
            if ("class" in t.attrs) and ("hideInheritedMethod" in t.attrs["class"]):
                continue
            sig_col = t.find("td", class_="summaryTableSignatureCol")
            if sig_col is None:
                continue
            meth_sig = sig_col.find(class_="summarySignature").text
            meth_name = meth_sig.split("(")[0].strip()
            new_meth = ASClassMethod(
                meth_name,
                meth_sig,
                " ".join(sig_col.find(class_="summaryTableDescription").text.strip().split())
            )
            self.class_methods.append(new_meth)

    def _make_consts(self):
        # Find and Parse Class Constants
        self.class_constants = []
        constant_table = self.soup.find("table", id="summaryTableConstant")
        if constant_table is None:
            return
        for t in constant_table.find_all("tr"):
            if ("class" in t.attrs) and ("hideInheritedConstant" in t.attrs["class"]):
                continue
            sig_col = t.find("td", class_="summaryTableSignatureCol")
            if sig_col is None:
                continue
            sum_tab = sig_col.find(class_="summaryTableDescription").extract()
            const_sig = sig_col.text.strip()
            const_name = const_sig.split(":")[0].strip()
            new_const = ASClassConst(
                const_name,
                const_sig,
                ' '.join(sum_tab.text.strip().split())
            )
            self.class_constants.append(new_const)

    def _make_connects(self):
        # Connect (in a very crude manner) bits of code in the web page and parsed code pieces
        # This is one of the least trust-worthy parts of this process

        self.valid_code = [
            z.strip() for z in [y for y in [xx.text.strip() for xx in self.soup.find_all("code")] if y]
            if (" function get " not in z) and
               (" function set " not in z) and
               (" " in z)
        ]
        code_connect = {}
        self.to_string_format = None
        for code_line in self.valid_code:
            if (self.class_name in code_line) and ("[" in code_line) and ("]" in code_line):
                self.to_string_format = code_line
            for const in self.class_constants:
                if const.name in code_line:
                    code_connect[const.name] = code_line
            for meth in self.class_methods:
                if meth.name in code_line and "function" in code_line:
                    code_connect[meth.name] = code_line
        self.code_connect = code_connect

    def _make_constructor(self):
        # The constructor is one of the more complicated parts of this process
        # as we need to identify which properties correspond to which input arguments
        # This is done by matching variable names and types;
        # then matching types and contains the first letter. Any input argument
        # which was not identified with a property is assumed to be an input to the super function
        try:
            self.con_code = self.code_connect[self.class_name]
        except KeyError:
            raise UnknownConstructorError
        self.con_args = [
            ASConArg(con_parts[0], con_parts[1], con_parts[2], False)
            for con_parts in re.findall(r"(\w+)\s*:\s*(\w+)\s*(?:\=\s*(\w+))?", self.con_code)
        ]

        eaten_cons = set()

        # Round 1 - Matching names and types
        for con_arg_i, con_arg_obj in enumerate(self.con_args):
            con_used = self.class_props.connect(con_arg_i, con_arg_obj, 0)
            if con_used:
                eaten_cons.add(con_arg_obj.name)

        # Round 2 - Only matching types and contains the first letter
        for con_arg_i, con_arg_obj in enumerate(self.con_args):
            if con_arg_obj.name in eaten_cons:
                continue
            con_used = self.class_props.connect(con_arg_i, con_arg_obj, 1)
            if con_used:
                eaten_cons.add(con_arg_obj.name)

        # All other constructor arguments are assumed to go into super
        self.con_super_args = [con_arg_obj for con_arg_obj in self.con_args if con_arg_obj.name not in eaten_cons]

    def _make_import(self):
        # Identify any imports from all the types which have been parsed which would need an import
        self.class_imports = {
            known_imports[iobj.type]
            for iobj in self.class_props.get_properties()
            if iobj.type in known_imports
        }

        for iobj in self.con_args:
            if iobj.type in known_imports:
                self.class_imports.add(known_imports[iobj.type])

    def __init__(self, soup) -> None:
        self.soup = soup
        self._make_sig()
        self._make_props()
        self._make_methods()
        self._make_consts()
        self._make_connects()
        self._make_constructor()
        self._make_import()

    def __str__(self):
        return "ActionScriptMaker(" \
               f"Construct Code={self.con_code}," \
               f"Construct Args={self.con_args}," \
               f"Inheritance={self.inher_sig}, " \
               f"Signature='{self.class_sig}', " \
               f"Properties={self.class_props}, " \
               f"Methods={self.class_methods}, " \
               f"Constants={self.class_constants}, " \
               f"IDCode={self.valid_code}, " \
               f"Connections={self.code_connect})"


class ASMKnownFN:
    # Due to the somewhat simple nature of toString() and clone()
    # We can mostly automatically create these, because we don't have any model of
    # parent objects, generate generic arguments and then edit in the manual step
    fn_full_temp = Template("""

        // {{ temp.method_desc }}
        {{ temp.method_con }}
        {
            {{ temp.method_body }}
        }""")

    def __init__(
            self,
            method: ASClassMethod,
            maker: ActionScriptMaker
    ):
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
    parent_args = {
        "Event": ["type", "bubbles", "cancelable", "eventPhase"],
        "ErrorEvent": ["type", "bubbles", "cancelable", "eventPhase", "text"],
        "TextEvent": ["type", "bubbles", "cancelable", "eventPhase", "activating"],
        "ActivityEvent": ["type", "bubbles", "cancelable", "eventPhase", "activating"],
        "Object" : [],
        "MouseEvent" : [],
        "GestureEvent" : ["localX", "localY","ctrlKey","altKey","shiftKey","buttonDown"]
    }

    def __post_init__(self):
        par_obj = self.maker.inher_sig[1]
        rv_args = [f'"{pa}"' for pa in self.parent_args[par_obj]]
        # Because toString sometimes has a description of the function output in a nice parsable format
        # we can use that instead of guessing based on class properties
        largl = [xx.name.strip() for xx in self.maker.class_props.get_properties_by_con_order()]
        if (self.maker.to_string_format is not None) and ("..." not in self.maker.to_string_format):
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
    parent_args = {
        "Event": ["type", "bubbles", "cancelable"],
        "ErrorEvent": ["type", "bubbles", "cancelable", "eventPhase", "text", "errorID"],
        "TextEvent": ["type", "bubbles", "cancelable", "eventPhase", "text"],
        "ActivityEvent": ["type", "bubbles", "cancelable", "eventPhase", "activating"],
        "Object" : [],
        "MouseEvent":["localX", "localY", "relatedObject","ctrlKey","altKey","shiftKey","buttonDown"],
        "GestureEvent":["localX", "localY","ctrlKey","altKey","shiftKey","buttonDown"]
    }

    def __post_init__(self):
        par_obj = self.maker.inher_sig[1]
        args = [f'this.{pa}' for pa in self.parent_args[par_obj]]
        # We already know the constructor arguments -> class properties, so reuse that
        args.extend(f'this.{x.name.strip()}' for x in self.maker.class_props.get_properties_with_con_order())
        args = ",".join(args)
        fn_temp = Template('return new {{class_name}}({{args}});')
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
            method_str += Template("""

        public function get {{ c.name }}() : {{ c.type }}
        {
            return this._{{ c.name }};
        }
        """).render(c=c)

    return method_str


def write_code(maker: ActionScriptMaker):
    # Write the code itself using all the pieces from the soup
    asmt = ActionScriptTemplate()
    asmt.class_sig = maker.class_sig
    asmt.class_parent = maker.inher_sig[1]
    asmt.class_constants = "\n        ".join([
        f"{maker.code_connect[c.name]}; // {c.desc}"
        for c in maker.class_constants
    ])
    asmt.class_properties = "\n        ".join([
        f"{'private' if c.readonly else 'public'} var {'_' if c.readonly else ''}{c.name}: {c.type}; // {c.desc}"
        for c in maker.class_props.get_properties_by_con_order()
    ])
    asmt.con_def = maker.con_code
    asmt.super_args = ",".join(x.name for x in maker.con_super_args)
    asmt.con_body = "\n            ".join([
        f"this.{'_' if c_arg.readonly else ''}{c_arg.name} = {c_arg.con_arg.name};"
        for c_arg in maker.class_props.get_properties_with_con_order()
    ])
    asmt.methods = make_method_str(maker)
    asmt.imports = "\n    ".join(maker.class_imports)

    return asm_event_template.render(temp=asmt)


def main():
    p_dir = Path("..") / "as_gen"
    p_dir.mkdir(parents=True, exist_ok=True)
    gen_files = [x.stem for x in p_dir.glob("*.as")]
    html_files = list((Path("..") / "output").glob("*.html"))
    # html_files = [Path("..") / "output" / "AVPauseAtPeriodEndEvent.html"]
    for html_file in html_files:
        class_name = html_file.stem
        # Comment this out to redo everything
        # if class_name in gen_files:
        #    continue
        html_doc = html_file.read_text()
        soup = BeautifulSoup(html_doc, 'html.parser')
        try:
            asm_maker = ActionScriptMaker(soup)
            (p_dir / f"{class_name}.as").write_text(write_code(asm_maker).strip())
            print(f"Completed {class_name}! Please double check to ensure there are no issues")
        except UnknownConstructorError as e:
            print("")
            print(class_name, "FAILED!")
            print("Error: unable to find a constructor definition.")
            (p_dir / f"{class_name}.as").write_text("// FAILED")


if __name__ == "__main__":
    main()
