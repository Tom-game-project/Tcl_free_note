
package require sqlite3

sqlite3 db ./sample.db

set resultset [db eval { SELECT id, name FROM mytbl }]
foreach row $resultset {
  puts $row
}
db eval { DROP TABLE mytbl } -list
db close