import csv
import os
from flask import Flask, render_template, request
from models_examples.py import *

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = 'postgresql://postgres:34373437@localhost/postgres'
app.config["SLQALCHEMY_TRACK_MODIFICATIONS"] = False
db.init_app(app)

# def main():
#    db.create_all()   ----   This was used to load create all db.model's from models.py ( resulting in new tables )

def main():
    f = open('users.csv')
    reader = csv.reader(f)
    for name, team_n, status in reader:
        userForm = Users(name=name, team_n=team_n, status=status)
        db.session.add(userForm)
        users_list = Users.query.all()
        for user in users_list:
            print(user.name, user.team_n, user.status)
#        print("Added new user %s with team id %d and status %s" % (name, int(team_n), status))
    db.session.commit()
if __name__ == "__main__":
    with app.app_context():
        main()
