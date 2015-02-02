require 'sinatra'
require 'sinatra/reloader'

get '/' do
	"Hello world."
end

# test in post man
post '/catperson' do
	name = params["name"]
	"Hi #{name}!"
	cat_person = params["cat_person"]

	if cat_person == "true"
		"Oh no, #{name}! You're a cat person?"
	elsif cat_person == "false"
		"Nice, #{name}. Cats are lame."
	end
end

# go to http://localhost:4567/reverse
get '/:name' do
	name = params["name"].capitalize
	"Hello, #{name}!"
end


get '/reverse/:string' do
	string = params["string"].reverse
	string
end