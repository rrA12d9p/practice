require 'pg'
require 'active_record'

require 'sinatra'
require 'sinatra/reloader'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'growler_db'
)

class User < ActiveRecord::Base
	has_many :posts 
end

class Post < ActiveRecord::Base
	belongs_to :user
end

get '/:name' do
	@name = params[:name]
	@user = User.find_by(name: @name)
	# return erb :page
end