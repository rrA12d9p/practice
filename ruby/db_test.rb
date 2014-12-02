require "pg"

conn = PG.connect(
	hostaddr: "127.0.0.1", 
	port: 5432, 
	dbname: "wdi")

new_student = {}

puts "==New student=="
puts "Name:"
new_student[:name] = gets.chomp.capitalize

puts "Email:"
new_student[:email] = gets.chomp.capitalize

puts "Age:"
new_student[:age] = gets.chomp.to_i

puts "Hometown:"
new_student[:hometown] = gets.chomp.capitalize

insert = "INSERT INTO students (name, email, age, hometown) VALUES ($1, $2);"

conn.prepare("student_insert_query", insert)
conn.exec_prepared("student_insert_query", [new_student[:name], new_student[:age]])


all_students = conn.exec("SELECT * FROM students;")

all_students.each do |student|
	p student
end