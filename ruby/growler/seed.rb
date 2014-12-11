require 'pg'

db_conn = PG.connect(:dbname => 'growler_db', :host => 'localhost')

users = [
  "Trey",
  "Ian",
  "Andy",
  "Weston",
  "Austin"
]

users.each do |user|
	user.gsub!("'", "’")
  sql  = "INSERT INTO users (username) "
  sql += "VALUES ('#{username}');"

  db_conn.exec(sql)

end

db_conn.close