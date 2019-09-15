#!/usr/bin/python3

import datetime
from flask import Flask
from flask import render_template
app = Flask(__name__)

@app.route("/")
def index():
    return "Hello, world!!!"
@app.route("/adam")
def adam():
    return "Hello madafaka!"
@app.route("/<string:name>")
def hello(name):
    return "<h1>hello, %s<h1>" % (name)
@app.route("/david")
def index2():
    trolololol = "trolololol"
    now = datetime.datetime.now()
    names = {"one": 1, "two": 2}
    bday = now.month == 7 and now.day == 2
    return render_template("table.html", headhead=trolololol, bday=bday, names=names)
