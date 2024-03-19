package require sqlite3

sqlite3 db ./sample.db

db eval { CREATE TABLE mytbl (id INT,name CHAR(10)) }
db eval { INSERT INTO mytbl (id ,name) VALUES (1,'apple') }
db eval { INSERT INTO mytbl (id ,name) VALUES (2,'banana') }
db eval { INSERT INTO mytbl (id ,name) VALUES (3,'candy') }
set resultset [db eval { SELECT id, name FROM mytbl }]
foreach row $resultset {
  puts $row
}
db close