import os
import csv
from flask import Flask, render_template, request, flash, redirect, url_for
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from werkzeug.utils import secure_filename
import create
import models_examples
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

dba = SQLAlchemy()
engine = create_engine('postgresql://postgres:34373437@localhost/postgres')
db = scoped_session(sessionmaker(bind=engine))
UPLOAD_FOLDER = '/root/N3Home/GIT/lecture0/app-dash/static/uploads/'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'csv'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
dba.init_app(app)
# if __name__ == "__main__":

# NOTE: Temporary adjusted to return true for testing:

def allowed_file(filename):
   return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route("/")
def index():
    users = db.execute("SELECT name, team, status FROM status JOIN team ON status.team_n = team.id").fetchall()
    return render_template("index.html", user=users)

@app.route("/upload", methods=['GET','POST'])
def upload_file():
    if request.method =='POST':
        # check if the post request has file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            create.main(filename)
            return redirect('/')



