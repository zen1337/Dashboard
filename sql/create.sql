sudo -u postgres psql

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
