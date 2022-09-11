from collections import namedtuple
from dataclasses import dataclass

ASClassMethod = namedtuple("ASClassMethod", ["name", "sig", "desc"])
ASClassConst = namedtuple("ASClassConst", ["name", "sig", "desc"])


class UnknownFileError(NameError):
    pass


@dataclass
class ActionScriptTemplate:
    class_package: str = ""
    class_sig: str = ""
    class_parent: str = ""
    class_constants: str = ""
    class_properties: str = ""
    con_def: str = ""
    super_args: str = ""
    con_body: str = ""
    methods: str = ""
    imports: str = ""
    doc_url: str = ""


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
        self.prop_list = {}

    def add_property(self, _name, _type, _desc, _readonly):
        self.prop_list[_name] = ASClassProp(_name, _type, _desc, _readonly)

    def valid(self):
        return len(self.prop_list.keys()) > 0

    def reset(self):
        self.prop_list = {}

    def get_property(self, name):
        return self.prop_list[name]

    def get_properties(self):
        return list(self.prop_list.values())

    def _get_max_con_arg(self):
        orders = [x.con_arg_order for x in self.get_properties()]
        return orders[0] if len(orders) == 1 else max(*orders)

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
            return []
        rv, frv = self._get_co_prop_helper()
        rv.extend(frv)
        return rv

    def get_properties_with_con_order(self):
        if not self.valid():
            return []
        rv, _ = self._get_co_prop_helper()
        return rv

    def get_properties_without_con_order(self):
        if not self.valid():
            return []
        _, frv = self._get_co_prop_helper()
        return frv

    def connect(self, con_arg_index, in_con_arg, stage):
        con_arg_used = False
        for prop_name, prop_obj in self.prop_list.items():
            if stage == 0:
                prop_name_in_con = (
                    prop_name.lower().strip() in in_con_arg.name.lower().strip()
                )
            else:
                prop_name_in_con = (
                    prop_name[0].lower().strip() in in_con_arg.name.lower().strip()
                )

            prop_type_match = prop_obj.type == in_con_arg.type
            prop_not_used = prop_obj.con_arg_order < 0

            if prop_name_in_con and prop_type_match and prop_not_used:
                prop_obj.connect_to_con_arg(con_arg_index, in_con_arg)
                con_arg_used = True
        return con_arg_used

    def __str__(self):
        return f"<ASClassPropList : {self.get_properties()}>"
