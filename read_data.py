import json
from functools import cache
from pathlib import PurePath, PurePosixPath

from utils.structs import ASConArg, UnknownFileError

with open("class_parsed.json", "r") as fp:
    class_cache = json.load(fp)
class_path_to_file = {v["class_path"]: k for k, v in class_cache.items()}
class_path_to_info = {v["class_path"]: v for v in class_cache.values()}


@cache
def get_info(in_key):
    try:
        if isinstance(in_key, PurePath):
            return class_cache[str(PurePosixPath(in_key))]
        elif isinstance(in_key, str) and ("/" in in_key):
            return class_cache[in_key]
        elif isinstance(in_key, str):
            return class_path_to_info[in_key]
        raise ValueError(f"Unknown Key : {in_key}")
    except KeyError as e:
        raise UnknownFileError from e


def get_parents(file_key):
    file_info = get_info(file_key)
    return file_info["inheritance_links"]


def get_parent(file_key):
    file_info = get_info(file_key)
    return file_info["inheritance_links"][file_info["inheritance"][1]]


def get_used_types(in_details):
    used_types = {}
    for detail in in_details:
        used_types |= detail["types_used"]
    return {k: v for k, v in used_types.items() if v in class_cache}


def get_import_path(file_key, in_type):
    file_info = get_info(file_key)
    types_to_key = get_used_types(file_info["details"])
    type_key = types_to_key.get(in_type, None)
    if type_key is None:
        return None
    type_info = get_info(type_key)
    return (
        None
        if tuple(type_info["package"]) == ("Top", "Level")
        else f"import {type_info['class_path']};"
    )


def get_constructor(file_key):
    file_info = get_info(file_key)
    return file_info["constructor"]


def get_constructor_args(file_key):
    file_info = get_info(file_key)
    return [ASConArg(*con_arg) for con_arg in file_info["constructor_args"]]


def get_parent_args(file_key):
    if c_parent := get_parent(file_key):
        return get_constructor_args(c_parent)
    return []


def is_top_level(file_key):
    file_info = get_info(file_key)
    c_pkg = tuple(file_info["package"])
    return ("Top", "Level") == c_pkg


def get_class_sig(file_key):
    file_info = get_info(file_key)
    return " ".join(file_info["class"])


def get_inherit_sig(file_key):
    file_info = get_info(file_key)
    return file_info["inheritance"]


def get_class_props(file_key):
    file_info = get_info(file_key)
    return file_info["properties"]


def get_class_methods(file_key):
    file_info = get_info(file_key)
    return [xx for xx in file_info["methods"] if xx[0] != file_info["class_name"]]


def get_class_consts(file_key):
    file_info = get_info(file_key)
    return file_info["constants"]


def get_class_details(file_key):
    file_info = get_info(file_key)
    return file_info["organized_details"]


def get_class_package(file_key):
    file_info = get_info(file_key)
    return file_info["package"]


def get_string_format(file_key):
    file_info = get_info(file_key)
    return file_info["package"]
