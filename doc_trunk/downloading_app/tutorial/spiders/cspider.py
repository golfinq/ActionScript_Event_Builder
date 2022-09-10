import json
import logging
from pathlib import Path

import scrapy
from bs4 import BeautifulSoup
from scrapy_splash import SplashRequest

tld_doc_dir = Path("..") / "doc_pages"

adobe_url = "https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/"
local_url = "http://127.0.0.1:8000/langref/"


def fix_url(in_url):
    return in_url.replace(adobe_url, local_url)


def convert_url_into_path(in_url):
    global tld_doc_dir
    url_chopped = in_url.replace(
        "http://127.0.0.1:8000/langref", ""
    )
    parts = url_chopped.split("/")
    tfile_name = parts.pop()
    if not parts:
        return tld_doc_dir / tfile_name
    c_dir = tld_doc_dir / parts.pop(0)
    for pp in parts:
        c_dir /= pp
    c_dir.mkdir(parents=True, exist_ok=True)
    return c_dir / tfile_name


class SimpleJSWalker(scrapy.Spider):
    name = "simplejswalker"
    
    def start_requests(self):
        start_urls = [x.strip() for x in Path("url_list.txt").read_text().split()]
        for url in start_urls:
            yield SplashRequest(url=fix_url(url), callback=self.parse, endpoint="render.html")
    
    def parse(self, response: scrapy.http.Response):
        dest = convert_url_into_path(response.url)
        dest.write_text(response.body.decode("utf8"))


class AdobeDepWalker(scrapy.Spider):
    name = "depwalker"
    start_urls = [
        "http://127.0.0.1:8000/langref/package-summary.html"
    ]
    all_urls = {
        "http://127.0.0.1:8000/langref/package-summary.html"
    }
    
    def start_requests(self):
        url = self.start_urls.pop()
        logging.info(f"Requesting {str(url)}")
        yield SplashRequest(url=fix_url(url), callback=self.parse, endpoint="render.html")
    
    def parse(self, response: scrapy.http.Response):
        logging.info(f"Recieved : {str(response.url)}")
        found_urls = []
        dest = convert_url_into_path(response.url)
        dest.write_text(response.body.decode("utf8"))
        
        soup = BeautifulSoup(response.body, "html.parser")
        # Searching links found on package summary pages
        pkg_table = soup.find(id="summaryTableId")
        if pkg_table is not None:
            for t_row in pkg_table.find_all("tr"):
                for l_tag in t_row.find_all("a"):
                    link_loc = l_tag.attrs["href"].strip()
                    link_loc = f"{local_url}{link_loc}"
                    if link_loc not in self.all_urls:
                        self.all_urls.add(link_loc)
                        found_urls.append(link_loc)
        
        # Searching links in class Summary Pages
        class_table = soup.find(id="summaryTableIdClass")
        if class_table is not None:
            for t_row in class_table.find_all("tr"):
                for l_tag in t_row.find_all("a"):
                    link_loc = l_tag.attrs["href"].strip()
                    link_loc = response.url.rsplit("/", 1)[0] + "/" + link_loc
                    if link_loc not in self.all_urls:
                        self.all_urls.add(link_loc)
                        found_urls.append(link_loc)
        
        for f_url in found_urls:
            logging.info(f"Requesting : {str(f_url)}")
            yield SplashRequest(url=fix_url(f_url), callback=self.parse, endpoint="render.html")
