import csv
from flask import Flask, render_template, request, send_file
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from flask_uploads import UploadSet, configure_uploads, DOCUMENTS


app = Flask(__name__)

engine = create_engine('postgresql://postgres:34373437@localhost/postgres')
db = scoped_session(sessionmaker(bind=engine))

docs = UploadSet('datafiles', DOCUMENTS)
app.config['UPLOADED_DATAFILES_DEST'] = 'static/uploads'
configure_uploads(app, docs)


# if __name__ == "__main__":

@app.route("/")
def index():
    users = db.execute("SELECT name, team, status FROM status JOIN team ON status.team_n = team.id").fetchall()
    return render_template("index.html", user=users)

@app.route("/csvread", methods=['POST'])
def csvread():
    csvinput = request.form.get("myfile")
    filename = docs.save(request.files["myfile"])
    for x in filename:
        print(x)

