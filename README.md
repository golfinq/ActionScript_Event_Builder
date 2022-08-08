# ActionScript_Event_Builder
A pile of code used to download and convert ActionScript Event documentation and convert it into ActionScript files. Broken up into three main scripts

## Downloading (1_downloading_app)
A Scrapy/Splash project which downloads the documentation after a Splash docker instance renders the page with JavaScript. While it won't work perfectly in the browser after downloading, all the DOM is correct which allows for correct parsing. If you want to use this, put in a `USER_AGENT` in `settings.py`. I purposely set the download rate to be very slow to not draw the ire of adobe.

## Converting (2_AS_event_app)
A python script which parses the DOM with `BeautifulSoup`, breaks it apart, and puts it back together into a ActionScript script. It may or may not work and requires manual inspection.

## Verification/inspection (3_comparing_app)
A Flask App which displays the code next to the appropriate documentation page to allow for easy comparison to ensure everything should be correct.
