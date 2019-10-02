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
# db.session.add(user)
#
# SELECT * FROM Users;
#
# Users.query.all()
#
# SELECT * FROM users WHERE name = 'John';
#
# Users.query.filter_by(name='John').all()
#
# SELECT * FROM Users
#   WHERE name = 'John' LIMIT 1;
#
# Users.query.filter_by(status='Offline').first()
#
# SELECT COUNT(*) FROM Users WHERE status = 'Offline'
#
# SELECT * FROM Users WHERE id = 28;
#
# Users.query.filter_by(id=28).first()
# Users.query.get(28)
#
# UPDATE Users SET team_n = 1 WHERE name = 'Adam';
# 
# User_list = Users.query.get(6)
# User_list.team_n = 1
#
# DELETE FROM USers WHERE id = 28;
#
# User = Users.query.get(28)
# db.session.delete(flight)
#
# COMMIT;
# 
# db.session.commit()
#
# SELECT * FROM USERS ORDER BY name
#
# Users.query.order_by(Users.name.desc #asc# ()).all()
#
# SELECT * FROM Users WHERE team_n != 3
#
# Users.query.filter(Users.team_n != 3).all()
#
# SELECT * FROM Users WHERE name IN ('Adam, 'John');
#
# Users.query.filter(Users.name.in_(["Adam", "John"])).all()
#
# SELECT * FROM Users WHERE team_n = 1 AND onlinestatus > 500;
#
# Users.query.filter(and_(Users.team_n == 1, Users.onlinnestatus > 500)).all()
#                    or_
# and_ AND & or_ OR are special slqalchemy syntax that need to be imported on
#
# the begining of the file.
#
# SELECT * FROM Users JOIN teams ON teams.id = Users.team_n;
#
# db.session.query(Users, teams).filter(teams.id == Users.team_n).all()
#
#
#
