require 'colorize'

class Apartment
	attr_accessor:name, :address, :sqft, :num_beds, :num_baths, :renters

	def initialize(name)
		@name = name
		@address = ""
		@sqft = 0
		@num_beds = 0
		@num_baths = 0
		@renters = []
	end

	def add_tenant(name, age, gender)
		new_tenant = Person.new(name, age, gender)
		@renters << new_tenant
	end

	def evict_tenant(name)
		renter_names = @renters.map {|renter| renter.name }
		renter_index = renter_names.index(name)
		@renters.delete_at(renter_index)
	end

	def view_details
		puts "================================"
		puts "Apartment Details for #{@name}"
		puts "--------------------------------"
		puts "Name: #{@name.to_s.red} "
		puts "Address: #{@address.to_s.red}"
		puts "Sqft: #{@sqft.to_s.red}"
		puts "Beds: #{@num_beds.to_s.red}"
		puts "Baths: #{@num_baths.to_s.red}"

		renter_names = @renters.map {|renter| renter.name }
		puts "Renters: " + renter_names.join(", ").to_s.red
	end
end