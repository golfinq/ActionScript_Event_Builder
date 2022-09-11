$url = "http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/standalone.zip"

if (-not(Test-Path -Path "standalone.zip" -PathType Leaf)) {
    Invoke-WebRequest -Uri $url -OutFile "standalone.zip"
}

if (-not(Test-Path -Path "standalone_doc" -PathType Container)) {
    Expand-Archive "standalone.zip" .\standalone_doc\
}

python -m http.server --directory .\standalone_doc\