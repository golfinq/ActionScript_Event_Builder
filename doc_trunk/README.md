# Documentation Trunk

## About

This directory holds the documentation which will be parsed by the code as 
well as the code for downloading the documentation itself and putting it into a
parsable format. 

The issue comes from the fact that much of the documentation is reliant on 
javascript, and while using a javascript engine from within python is possible.
It is easier to use one to just render the page, then save the static HTML. The 
scripts in this directory accomplish that goal.

## Usage

There are three main parts

1. The raw documentation server, `start_server` - this script downloads 
the standalone documentation zip from [here](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/standalone.zip) 
then unzips it into  `standalone_doc` then starts a simple python http server in that directory ready to be served
2. The splash docker container, `start_splash` - this script launches a docker container with [splash](https://hub.docker.com/r/scrapinghub/splash/) 
running inside it which will render the documentation pages from the http server that was launched with `start_server`.
3. The scrapy spiders, `downloading_app` - this directory holds a `scrapy` project with two spiders which (using `scrapy-splash`) 
will send requests to splash pointing to the http server and store the responses in html pages in `doc_pages`

`doc_pages.7z` is the copy of all documentation downloaded using these scripts 

## Uncompress

To uncompress I recommend the cross-platform [peazip](https://peazip.github.io). 
Place the files in a `doc_pages` folder in this directory i.e the code 
looks for `.../doc_trunk/doc_pages/...`
