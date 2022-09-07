# ActionScript Event Builder 
A pile of code used to download and convert ActionScript Event documentation and convert it into ActionScript files. Broken up into three main scripts

## Downloading (doc_trunk)
A Scrapy/Splash project which downloads the documentation after a Splash docker 
instance renders the page with JavaScript. 
While it won't work perfectly in the browser after downloading, 
all the DOM is correct which allows for correct parsing. A copy of previously
downloaded documentation is included.
The `README` in that directory has more information.

## Parsing (ingest_data.py)
A python script which parses the DOM with `BeautifulSoup`, then converts it into a
python dictionary containing the important parts of the documentation page for
code generation. This dictionary is then stored in `class_parsed.json` which
is indented for easy readability.

## Building (make_as.py)
A python script which parses the DOM with `BeautifulSoup` and using the cache from 
the previous step builds an actionscript file which should approximate the
class described by the documentation page

It may or may not work and requires manual inspection.

## Verification/inspection (comparison)
A Flask App which displays the code next to the appropriate documentation page to allow for easy comparison to ensure everything should be correct.
