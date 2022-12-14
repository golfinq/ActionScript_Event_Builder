import contextlib
import json
import re
from operator import attrgetter
from pathlib import Path, PurePosixPath

from bs4 import BeautifulSoup
from tqdm import tqdm

class_cache_file = Path("class_parsed.json")
class_cache = {}
if class_cache_file.exists():
    with open(class_cache_file, "r") as fp:
        class_cache = json.load(fp)

get_text = attrgetter("text")


def strip_get_text(in_tag):
    return get_text(in_tag).strip()


def get_soup(in_path):
    return BeautifulSoup(in_path.read_text(), "html.parser")


def lmap(in_func, *in_iters):
    return list(map(in_func, *in_iters))


def breakup_table(in_table_node):
    return [
        [td.text.strip() for td in tr.find_all("td")]
        for tr in in_table_node.find_all("tr")
    ]


def strip_list(in_val):
    if isinstance(in_val, (list, tuple)) and len(in_val) == 1:
        return in_val[0]
    return in_val


def parse_class_header_table(soup):
    class_defs = {}
    class_def_table = soup.find(class_="classHeaderTable")
    if class_def_table is not None:
        table_text = breakup_table(class_def_table)
        class_defs = {
            k.strip().lower(): strip_list(
                [xx.strip().replace(",", "") for xx in v.strip().split()]
            )
            for k, v in table_text
        }

        class_defs["class_name"] = class_defs["class"][-1]
        class_defs["class_type"] = class_defs["class"][0]
        class_pkg = class_defs["package"]
        pkg_path = ".".join(class_pkg) if isinstance(class_pkg, list) else class_pkg
        class_defs["class_path"] = f'{pkg_path}.{class_defs["class_name"]}'
    return class_defs


this_dir = Path(".").resolve()


def get_inheritance_from_soup(soup, file_path):
    global this_dir
    inherit_list = soup.find(class_="inheritanceList")
    if inherit_list is None:
        return {}
    return {
        a_tag.text.strip(): str(
            PurePosixPath(
                (
                    (file_path.parent / a_tag.attrs["href"].strip()).resolve()
                ).relative_to(this_dir)
            )
        )
        for a_tag in inherit_list.find_all("a")
    }


def get_constructor_from_organized_details(class_name, organized_details):
    with contextlib.suppress(KeyError, IndexError):
        return organized_details["constructor"][class_name][0]
    return ""


def get_props_from_soup(soup):
    soup_props = []
    prop_table = soup.find("table", id="summaryTableProperty")
    if prop_table is None:
        return soup_props
    for t in prop_table.find_all("tr"):
        if "class" in t.attrs and "hideInheritedProperty" in t.attrs["class"]:
            continue
        sig_col = t.find("td", class_="summaryTableSignatureCol")
        if sig_col is None:
            continue
        name_tag = sig_col.find("a", class_="signatureLink")
        desc_tag = " ".join(
            sig_col.select_one(".summaryTableDescription").text.strip().split()
        )

        next_sib = name_tag.find_next_sibling("a")
        next_sib = next_sib.text if next_sib else ""
        soup_props.append(
            [name_tag.text, next_sib, desc_tag, "[read-only]" in desc_tag]
        )

    return soup_props


def get_methods_from_soup(soup):
    soup_methods = []
    method_table = soup.find("table", id="summaryTableMethod")
    if method_table is None:
        return soup_methods
    for t in method_table.find_all("tr"):
        if ("class" in t.attrs) and ("hideInheritedMethod" in t.attrs["class"]):
            continue
        sig_col = t.find("td", class_="summaryTableSignatureCol")
        if sig_col is None:
            continue
        meth_sig = sig_col.find(class_="summarySignature").text
        meth_name = meth_sig.split("(")[0].strip()
        soup_methods.append(
            [
                meth_name,
                meth_sig,
                " ".join(
                    sig_col.find(class_="summaryTableDescription").text.strip().split()
                ),
            ]
        )
    return soup_methods


def get_constants_from_soup(soup):
    # Find and Parse Class Constants
    soup_constants = []
    constant_table = soup.find("table", id="summaryTableConstant")
    if constant_table is None:
        return []
    for t in constant_table.find_all("tr"):
        if ("class" in t.attrs) and ("hideInheritedConstant" in t.attrs["class"]):
            continue
        sig_col = t.find("td", class_="summaryTableSignatureCol")
        if sig_col is None:
            continue
        sum_tab = sig_col.find(class_="summaryTableDescription").extract()
        const_sig = sig_col.text.strip()
        const_name = const_sig.split(":")[0].strip()
        soup_constants.append(
            [const_name, const_sig, " ".join(sum_tab.text.strip().split())]
        )

    return soup_constants


def remap_link_to_file(in_link_tag, in_current_file):
    global thiS_dir
    try:
        return str(
            PurePosixPath(
                (in_current_file.parent / (in_link_tag.attrs["href"].strip())).resolve()
            ).relative_to(this_dir)
        )
    except AttributeError:
        return ""


def get_details_from_soup(soup, file_path):
    global this_dir
    soup_details = []
    for page_filter in soup.select("#pageFilter"):
        headers = page_filter.select(".detailHeader") or page_filter.select(
            "#detailHeader"
        )

        bodies = page_filter.select(".detailBody") or page_filter.select("#detailBody")
        for header, body in zip(headers, bodies):
            air_tag = (header.select(".detailHeaderName > span") or [None]).pop()
            details = {
                "name": strip_list(
                    lmap(strip_get_text, header.select(".detailHeaderName"))
                ),
                "type": strip_list(
                    lmap(strip_get_text, header.select(".detailHeaderType"))
                ),
                "is_air": "" if air_tag is None else air_tag.attrs["alt"],
            }

            code_tag = body.find("code")
            details["types_used"] = (
                {
                    link_tag.text.strip(): remap_link_to_file(link_tag, file_path)
                    for link_tag in code_tag.find_all("a")
                }
                if code_tag
                else {}
            )
            code_tag = code_tag.text.strip() if code_tag else ""
            details["code"] = code_tag
            soup_details.append(details)
    orgainized_details = {}
    for details in soup_details:
        detail_type = details["type"].lower()
        if detail_type not in orgainized_details:
            orgainized_details[detail_type] = {}
        orgainized_details[detail_type][details["name"]] = (
            details["code"],
            details["is_air"],
        )
    return soup_details, orgainized_details


def get_string_format_from_soup(soup, class_name):
    valid_code = list(
        filter(
            lambda z: " function get " not in z
            and " function set " not in z
            and " " in z,
            map(lambda x: x.text.strip(), soup.find_all("code")),
        )
    )

    return next(
        (
            code_line
            for code_line in valid_code
            if class_name in code_line and "[" in code_line and "]" in code_line
        ),
        None,
    )


def get_constructor_args(in_constructor):
    return list(
        re.findall(r"(\w+)\s*:\s*(\w+)\s*(?:\=\s*(.+?))?(?:,|\))", in_constructor)
    )


def write_to_cache_file():
    global class_cache
    with open(class_cache_file, "w") as fp:
        json.dump(class_cache, fp, indent=2)


def get_file_information(file_path):
    global class_cache
    path_key = str(PurePosixPath(file_path))
    if path_key in class_cache:
       return
    file_soup = get_soup(file_path)
    class_defs = parse_class_header_table(file_soup)
    if "class_name" not in class_defs:
        return
    class_defs["inheritance_links"] = get_inheritance_from_soup(file_soup, file_path)
    class_defs["properties"] = get_props_from_soup(file_soup)
    class_defs["methods"] = get_methods_from_soup(file_soup)
    class_defs["constants"] = get_constants_from_soup(file_soup)
    class_defs["details"], class_defs["organized_details"] = get_details_from_soup(
        file_soup, file_path
    )
    class_defs["string_format"] = get_string_format_from_soup(
        file_soup, class_defs["class_name"]
    )
    class_con = get_constructor_from_organized_details(class_defs["class_name"], class_defs["organized_details"])
    class_con_args = get_constructor_args(class_con)
    class_defs["constructor"] = class_con
    class_defs["constructor_args"] = class_con_args

    class_cache[path_key] = class_defs


def main():
    all_files = list(enumerate((Path("doc_trunk") / "doc_pages").rglob("*.html")))
    for i_path, path in tqdm(all_files):
        get_file_information(path)
        if (i_path % 1000) == 0:
            write_to_cache_file()
    write_to_cache_file()


if __name__ == "__main__":
    main()
