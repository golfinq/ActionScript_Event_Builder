import dill
import scrapy
import time

from pathlib import Path
from scrapy_splash import SplashRequest


class MySpider(scrapy.Spider):
    name = "jsscraper"
    start_urls = [x.strip() for x in Path("url_list.txt").read_text().split()]

    def start_requests(self):
        for url in self.start_urls:
            time.sleep(5.)
            page_name = url.split("/")[-1].split(".")[0]
            yield SplashRequest(
                url=url, callback=self.parse, endpoint=f'render.html'
            )

    def parse(self, response: scrapy.http.Response):
        page = response.url.split("/")[-1].split(".")[0]
        with open(Path("..") / "output" / f'{page}.html', 'wb') as f:
            f.write(response.body)
        time.sleep(5.)
