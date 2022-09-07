# Downloading App

Using scrapy and splash-scrapy we download adobe documentation into the `doc_pages` directory.

## Setup

Download and run the splash docker image

```bash
docker pull scrapinghub/splash
docker run -it -p 8050:8050 --rm scrapinghub/splash
```

Then set the `USER_AGENT`in `settings.py` for the spider

## Spiders

There are two spiders

- `python -m scrapy crawl simplejswalker` : Only downloads the urls in `url_list.txt`

- `python -m scrapy crawl depwalker` : Recursively downloads pages and builds the `classes_structure.json` file

## Note

This is purposely set to download things *very* slowly, 1 request per 10 seconds. A copy of all documentation downloaded with this is in `../doc_pages.7z`