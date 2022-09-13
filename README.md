# ActionScript Event Builder

A pile of code used to download and convert ActionScript documentation into ActionScript files. Broken up into four main stages

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

A python script uses  `class_parsed.json` to build an actionscript file specified by the
input path. This generated file should approximate the class described by the documentation page

It may or may not work and requires manual inspection.

## Verification/inspection (comparison)

A Flask App which displays the code next to the appropriate documentation page to allow for easy comparison to ensure everything should be correct.

## Current Generated ActionScript Files

Output files have been organized into the `output` directory which contains the following sub-directories

* `PR_7597` - The Original code for the [Ruffle PR #7597](https://github.com/ruffle-rs/ruffle/pull/7597)
* `PR_7974` - The Original code for the [Ruffle PR #7974](https://github.com/ruffle-rs/ruffle/pull/7974)