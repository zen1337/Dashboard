import os
import psycopg2
import csv

from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

engine = create_engine('postgresql://postgres:34373437@localhost/postgres')
# engine will take care of talking to the DB
db = scoped_session(sessionmaker(bind=engine))

def main():
    f = open('users.csv')
    reader = csv.reader(f)
    for nm, tm, st in reader:
        db.execute("INSERT INTO status (name, team_n, status) VALUES (:name, :team_n, :status)", {"name": nm,"team_n": tm, "status": st})
# Uncommen to write        db.commit()
    GetStatus = db.execute("SELECT name, team, status FROM status JOIN team ON status.team_n = team.id").fetchall() # fechall = run query and get all results return as list
    for name in GetStatus:
        print( "%s from %s is %s" % (name.name, name.team, name.status)) 

if __name__ == "__main__":
    main()
