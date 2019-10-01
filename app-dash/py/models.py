from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Users(db.Model):
    __tablename__ = "status_test"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    team_n = db.Column(db.Integer, nullable=False)
    status = db.Column(db.String, nullable=False)

class Teams(db.Model):
    __tablename__ = "team_test"
    id = db.Column(db.Integer, primary_key=True)
    team = db.Column(db.String, nullable=False)

#
#   Above code when run with db.create_all()
#   
#   Will result in following SQLq:
#   
#   CREATE TABLE Users (
#       id SERIAL PRIMARY KEY,
#       name VARCHAR NOT NULL,
#       team_n INTEGER NOT NULL,
#       status VARCHAR NOT NULL );
#
###################################################

#
# INSERT INTO Users ( name, team_n, status )
#   VALUES ('John', 1, 'Offline')
#
# user = Users(name="John", team_n=1, status="Offline")
# db.session.add(flight)
#
# SELECT * FROM Users;
#
# User.query.all()
#
# SELECT * FROM users WHERE name = 'John';
#
# User.query.filter_by(name='John').all()
#

