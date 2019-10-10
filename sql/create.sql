sudo -u postgres psql

pg_dump -h 127.0.0.1 -U postgres > dbexp.pgsql

CREATE TABLE StatusP (
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	status VARCHAR NOT NULL,
	duration INTEGER NOT NULL
);

Constrains

NOT NULL
UNIQUE
PRIMARY KEY
DEFAULT ( set it to 0 if not interacted )
CHECK
..

Insert:

INSERT INTO statusp
	(name, status, duration)
	VALUES ('Adam', 'offline', 165);

Select:

SELECT * FROM statusp

SELECT name, status FROM statusp;

SELECT * FROM statusp WHERE id = 3;

SELECT * FROM statusp WHERE duration > 200;

SELECT * FROM statusp WHERE status = 'Online' AND/OR duration < 200;

SELECT AVG(duration) FROM statusp WHERE status = 'Online';

SELECT COUNT(*) FROM statusp WHERE status = 'Offline';

SELECT MIN(duration) FROM statusp;

SELECT * FROM statusp WHERE status LIKE '%a%';

Update:

UPDATE statusp SET duration = 0 WHERE name = 'Adam' AND status = 'Offline';

Delete:

DELETE FROM statusp WHERE status = 'Offline';

Group results:

SELECT * From statusp LIMIT 2;

SELECT * FROM statusp ORDER BY duration ASC LIMIT 3;(DESC?)

SELECT status, COUNT(*) FROM statusp GROUP BY status;

(having)

SELECT status, COUNT(*) FROM statusp GROUP BY status HAVING COUNT(*) > 1;

Combining two tables with REFERENCES and JOIN.

CREATE TABLE xyz (
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	team_id INTEGER REFERENCES flights);

[ REFERENCES informs DB that the team_id is related to other table there-fore it secures it from DELETE or some other modification??? ]


SELECT name, team FROM names JOIN teams ON names.team_id = teams.id WHERE name = 'Adam';

LEFT JOIN and RIGHT JOIN <--- Selects all table content without a match, on their respected tables left/right --->

Group By:

SELECT team_id FROM names GROUP BY team_id HAVING COUNT(*) > 1;

SELECT * FROM teams WHERE id IN (SELECT team_id FROM names GROUP BY team_id HAVING COUNT(*) > 1);

# result: id 1 | team WAF

Basic Authentication:

SELECT * FROM users WHERE (username = username) AND (password = password);
SELECT * FROM users WHERE (username = 'admin') AND (password = '1' OR '1' = '1');

Rece Conditions example

# Runnin multiple querys and/or modyfining DB values at the same time.

SELECT balance FROM bank WHERE user_id = 1;

UPDATE bank SET balance = balance - 100 WHERE user_id = 1;

To mitigate we can use SQL Transactions with BEGIN & COMMIT

Add column to an existing table:

ALTER TABLE teams ADD COLUMN status data_type;

SQLAlchemy ^^
