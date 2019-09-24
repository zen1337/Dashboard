
from flask import Flask, render_template
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker


app = Flask(__name__)

engine = create_engine('postgresql://postgres:34373437@localhost/postgres')
db = scoped_session(sessionmaker(bind=engine))
# if __name__ == "__main__":

@app.route("/")
def index():
    users = db.execute("SELECT name, team, status FROM status JOIN team ON status.team_n = team.id").fetchall()
    return render_template("index.html", user=users)
