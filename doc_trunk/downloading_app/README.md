# Downloading App

Using scrapy and splash-scrapy we download adobe documentation into the `doc_pages` directory.

## Setup

Run the `start_server` and `start_splash` scripts then run one of the following spiders

## Spiders

There are two spiders

- `python -m scrapy crawl simplejswalker` : Only downloads the urls in `url_list.txt`

- `python -m scrapy crawl depwalker` : Recursively downloads pages by identifying links in pages which would lead to other classes