import html
from pathlib import Path

from flask import Flask, render_template, request, url_for

app = Flask(__name__, static_folder="./static", template_folder="./templates")

files = list((Path("..") / "as_gen").glob("*.as"))
files = sorted(files, key=lambda x: x.stem.lower())
file_dict = {ff.stem: ff for ff in files}


@app.route("/app", methods=["GET"])
def code_page():
    file_name = request.args.get("file")
    code_text = file_dict[file_name].read_text()
    return render_template(
        "app.jinja", code_name=file_name, code=html.escape(code_text)
    )


@app.route("/")
def index_page():
    return render_template("index.jinja", code_list=list(file_dict.keys()))


if __name__ == "__main__":
    app.run()
