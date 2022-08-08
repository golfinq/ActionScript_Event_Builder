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
    "DRMVoucher": "import flash.net.drm.DRMVoucher;"
}

ASClassProp = namedtuple("ASClassProp", ["name", "type", "desc", "readonly"])
ASClassMethod = namedtuple("ASClassMethod", ["name", "sig", "desc"])
ASClassConst = namedtuple("ASClassConst", ["name", "sig", "desc"])

@dataclass
class ASConArg:
    name: str = ""
    type: str = ""
    default: str = ""
    readonly: bool = False

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
        # Get Class Signature and Inheritance
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
        # Get Class Properties
        self.class_props = {}
        prop_table = self.soup.find("table", id="summaryTableProperty")
        for t in prop_table.find_all("tr"):
            if ("class" in t.attrs) and ("hideInheritedProperty" in t.attrs["class"]):
                continue
            sig_col = t.find("td", class_="summaryTableSignatureCol")
            if sig_col is None:
                continue
            name_tag = sig_col.find("a", class_="signatureLink")
            desc_tag = " ".join(sig_col.select_one(".summaryTableDescription").text.strip().split())
            new_prop = ASClassProp(
                name_tag.text,
                name_tag.find_next_sibling("a").text,
                desc_tag,
                "[read-only]" in desc_tag
            )
            self.class_props[new_prop.name] = new_prop

    def _make_methods(self):
        # Get Class Methods
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
        # Get Class Constants
        self.class_constants = []
        constant_table = self.soup.find("table", id="summaryTableConstant")
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
        self.con_code = self.code_connect[self.class_name]
        self.con_args = []
        for con_parts in re.findall(r"(\w+)\s*:\s*(\w+)\s*(?:\=\s*(\w+))?", self.con_code):
            self.con_args.append(
                ASConArg(
                    con_parts[0],
                    con_parts[1],
                    con_parts[2],
                    False
                )
            )


        self.con_arg_ordered_props = []
        self.con_arg_prop = {}

        eaten_cons = set()
        for con_arg_obj in self.con_args:
            for prop_obj_name in self.class_props:
                prop_obj = self.class_props[prop_obj_name]
                if (prop_obj.name.lower().strip() in con_arg_obj.name.lower().strip()) and (
                        prop_obj.type == con_arg_obj.type):
                    eaten_cons.add(con_arg_obj.name)
                    self.con_arg_prop[prop_obj.name] = con_arg_obj
                    con_arg_obj.readonly = prop_obj.readonly
                    self.con_arg_ordered_props.append(prop_obj)

        for class_prop_name in self.class_props:
            class_prop = self.class_props[class_prop_name]
            if class_prop not in self.con_arg_ordered_props:
                self.con_arg_ordered_props.append(class_prop)

        self.con_super_args = []
        for con_arg_obj in self.con_args:
            if con_arg_obj.name not in eaten_cons:
                self.con_super_args.append(con_arg_obj)



    def _make_import(self):
        self.class_imports = set()
        for iobj in self.con_arg_ordered_props:
            if iobj.type in known_imports:
                self.class_imports.add(known_imports[iobj.type])

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
    def __post_init__(self):
        par_obj = self.maker.inher_sig[1]
        if par_obj == "Event":
            fn_temp = Template('return this.formatToString("{{class_name}}","type","bubbles","cancelable","eventPhase"{{args}});')
        elif par_obj in ["ErrorEvent", "TextEvent"]:
            fn_temp = Template('return this.formatToString("{{class_name}}","type","bubbles","cancelable","eventPhase","text"{{args}});')
        elif par_obj == "ActivityEvent":
            fn_temp = Template('return this.formatToString("{{class_name}}","type","bubbles","cancelable","eventPhase","activating"{{args}});')
        else:
            raise TypeError(f"Unknown Parent Type = {par_obj}; do not know how to make toString signature!")
        rv_args = []
        if self.maker.to_string_format is not None:
            largl = [xx.name.strip() for xx in self.maker.con_arg_ordered_props]
            if "..." in self.maker.to_string_format:
                rv_args.extend(f'"{xx}"' for xx in largl)
            else:
                largl = [xx.lower() for xx in largl]
                rv_args.extend(
                    f'"{s_name.strip()}"'
                    for s_name, _ in re.findall(r"(\w+)=(\w+)", self.maker.to_string_format)
                    if s_name.strip().lower() in largl
                )
        else:
            rv_args = [f'"{x.name.strip()}"' for x in self.maker.con_arg_ordered_props]
        if rv_args:
            args = "," + ",".join(rv_args)
        else:
            args = ""
        self.method_body = fn_temp.render(class_name=self.maker.class_name, args=args)


class ASMClone(ASMKnownFN):
    def __post_init__(self):
        par_obj = self.maker.inher_sig[1]
        if par_obj == "Event":
            fn_temp = Template('return new {{class_name}}(this.type, this.bubbles, this.cancelable, {{args}});')
        elif par_obj == "ErrorEvent":
            fn_temp = Template('return new {{class_name}}(this.type, this.bubbles, this.cancelable, this.text, this.errorID, {{args}});')
        elif par_obj == "TextEvent":
            fn_temp = Template('return new {{class_name}}(this.type, this.bubbles, this.cancelable, this.text, {{args}});')
        elif par_obj == "ActivityEvent":
            fn_temp = Template('return new {{class_name}}(this.type, this.bubbles, this.cancelable, this.	activating{{args}});')
        else:
            raise TypeError(f"Unknown Parent Type = {par_obj}; do not know how to make clone signature!")
        args = ", ".join(f'this.{x.strip()}' for x in self.maker.con_arg_prop.keys())
        self.method_body = fn_temp.render(class_name=self.maker.class_name, args=args)


def make_method_str(maker: ActionScriptMaker):
    method_str = ""
    for method in maker.class_methods:
        if method.name == maker.class_name:
            continue

        if method.name == "toString":
            meth_make = ASMToString(method, maker)
        elif method.name == "clone":
            meth_make = ASMClone(method, maker)
        else:
            meth_make = ASMKnownFN(method, maker)
        method_str += str(meth_make)

    for c in maker.con_arg_ordered_props:
        if c.readonly:
            method_str += Template("""

        public function get {{ c.name }}() : {{ c.type }}
        {
            return this._{{ c.name }};
        }
        """).render(c=c)

    return method_str


def write_code(maker: ActionScriptMaker):
    asmt = ActionScriptTemplate()
    asmt.class_sig = maker.class_sig
    asmt.class_parent = maker.inher_sig[1]
    asmt.class_constants = "\n        ".join([
        f"{maker.code_connect[c.name]}; // {c.desc}"
        for c in maker.class_constants
    ])
    asmt.class_properties = "\n        ".join([
        f"public var {'_' if c.readonly else ''}{c.name}: {c.type}; // {c.desc}"
        for c in maker.con_arg_ordered_props
    ])
    asmt.con_def = maker.con_code
    asmt.super_args = ",".join(x.name for x in maker.con_super_args)
    asmt.con_body = "\n            ".join([
        f"this.{'_' if c_arg.readonly else ''}{p_name} = {c_arg.name};"
        for p_name, c_arg in maker.con_arg_prop.items()
    ])
    asmt.methods = make_method_str(maker)
    asmt.imports = "\n    ".join(maker.class_imports)

    return asm_event_template.render(temp=asmt)


def main():
    p_dir = Path("..") / "as_gen"
    p_dir.mkdir(parents=True, exist_ok=True)
    gen_files = [x.stem for x in p_dir.glob("*.as")]
    html_files = list((Path("..") / "output").glob("*.html"))
    for html_file in html_files:
        class_name = html_file.stem
        html_doc = html_file.read_text()
        soup = BeautifulSoup(html_doc, 'html.parser')
        try:
            asm_maker = ActionScriptMaker(soup)
            (p_dir / f"{class_name}.as").write_text(write_code(asm_maker).strip())
            print(f"Completed {class_name}! Please double check to ensure there are no issues")
        except Exception as e:
            print("============================")
            print(class_name, "FAILED! ")
            print("Error:")
            print(e)
            print("")
            print("============================")
            (p_dir / f"{class_name}.as").write_text("// FAILED")



if __name__ == "__main__":
    main()
