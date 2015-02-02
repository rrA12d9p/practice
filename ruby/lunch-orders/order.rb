require 'active_record'

# ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :host => "localhost",
  :database => "lunch_orders"
)

class Order < ActiveRecord::Base
end