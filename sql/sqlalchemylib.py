import os
import psycopg2

from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

engine = create_engine(os.getenv("DATABASE_URL"))
# engine will take care of talking to the DB
db = scoped_session(sessionmaker(bind=engine))

def main():
    flights = db.execute("SELECT name, team_n, status FROM status JOIN team ON status.team_id = team.id").fetchall() # fechall = run query and get all results return as list
    for name in flights:
        print( "%s from %s is %s" % (status.name, status.team_id, status.status)) 

if __name__ == "__main__":
    main()
