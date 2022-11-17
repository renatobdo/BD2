
CREATE TABLE foo (oldjson char(250));
INSERT INTO foo VALUES ('{"name":"Bond","first":"James","ID":"007"}');
SELECT * FROM foo;

CREATE TABLE bar (our_data JSON);
INSERT INTO bar VALUES ('{"name":"Bond","first":"James","ID":"007"}');
SELECT * FROM bar;

INSERT INTO foo VALUES ('{"name":"Smart","first":"Maxwell","ID":"86"');
INSERT INTO bar VALUES ('{"name":"Smart","first":"Maxwell","ID":"86"');
INSERT INTO bar VALUES ('{"name":"Smart","first":"Maxwell","ID":"86"}');
SELECT * FROM bar;
SELECT JSON_PRETTY(our_data) FROM bar;