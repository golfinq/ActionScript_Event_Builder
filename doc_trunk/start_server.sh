#!/usr/bin/env bash

STANDALONE_URL=http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/standalone.zip
[ ! -f "standalone.zip" ] && wget "$STANDALONE_URL"
[ ! -d "standalone_doc" ] && (mkdir standalone_doc && unzip -d standalone_doc/ "standalone.zip")
python -m http.server --directory ./standalone_doc/
