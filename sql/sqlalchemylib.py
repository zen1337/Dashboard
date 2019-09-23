import os

from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

engine = create_engine(os.getenv("DATABASE_URL"))
# engine will take care of talking to the DB
db = scoped_session(sessionmaker(bind=engine))

def main():
    flights = db.execute("SELECT name, status, team FROM statusp JOIN teams ON statusp.team_id = teams.id").fetchall() # fechall = run query and get all results return as list
    for name in statusp:
        print( "%s from %s is %s" % (statusp.name, statusp.team_id, statusp.status)) 

if __name__ == "__main__":
    main()
