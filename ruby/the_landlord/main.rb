require 'colorize'

require_relative 'person.rb'
require_relative 'apartment.rb'
require_relative 'menu.rb'

# model ->
	all_apartments = []
	names = ["Trey", "Ian", "Min", "Kurt", "Sherry", "Sung", "Alison", "Mo", "Akintola", "Austin"]
	all_people = [Person.new(names.sample, rand(21..45), ['M','F'].sample), Person.new(names.sample, rand(21..45), ['M','F'].sample), Person.new(names.sample, rand(21..45), ['M','F'].sample), Person.new(names.sample, rand(21..45), ['M','F'].sample), Person.new(names.sample, rand(21..45), ['M','F'].sample)]

	all_apartments << Apartment.new("Apt 1")
	all_apartments << Apartment.new("Apt 2")
	all_apartments << Apartment.new("Apt 3")

	address_array = ["123 Fake St. Apt. #{rand(1000)}, Washington, D.C.", "1333 15th St. Apt. #{rand(1000)}, Washington, D.C.", "742 Evergreen Terrace Apt. #{rand(1000)}, Springfield, Everytown"]

	all_apartments.each do |apartment|
		sqft = rand(500..4000)
		beds = rand(1..4)
		baths = rand(0..2)

		num_renters = rand(1..beds)
		renters = all_people.sample(num_renters)

		apartment.address = address_array.sample
		apartment.sqft = sqft
		apartment.num_beds = beds
		apartment.num_baths = baths
		apartment.renters = renters
	end
# model <-

main_menu = Menu.new('Main Menu')
apartment_menu = Menu.new('Apartment Menu')
select_apartment_menu = Menu.new('Select Apartment')

main_menu_options = ["Select apartment",
										 "Add apartment",
										 "Remove apartment",
										 "Quit"		
										]

apartment_menu_options = ["View apartment details",
									  		  "Add a tenant to an apartment",
									 			  "Evict a tenant from an apartment",
									  		  "Go back"
									  		 ]

main_menu.add_options(main_menu_options)
apartment_menu.add_options(apartment_menu_options)

while true
	selected = main_menu.list_options
	apartment_names = all_apartments.map {|apt| apt.name}
	options = apartment_names
	
	case selected[1]
		when "Select apartment"
			#list all apartments

			select_apartment_menu.options = apartment_names << "Go back"
			selected = select_apartment_menu.list_options
			next if selected[1] == "Go back"

			apt_index = selected[0]-1
			apartment = all_apartments[apt_index]
			
			while true
				action = apartment_menu.list_options

				case action[1]
					when "View apartment details"
						apartment.view_details
					when "Add a tenant to an apartment"
						puts "Name of new tenant:"
						name = gets.chomp.capitalize
						puts "Tenant age:"
						age = gets.chomp.to_i
						puts "Tenant gender (M/F):"
						gender = gets.chomp

						apartment.add_tenant(name, age, gender)
					when "Evict a tenant from an apartment"
						# evict a tenant
						tenants_list = apartment.renters
						tenants_names_list = tenants_list.map {|tenant| tenant.name}

						evict_tenant_menu_options = tenants_names_list << "Go back"
						evict_tenant_menu = Menu.new("Evict a Tenant")
						evict_tenant_menu.add_options(evict_tenant_menu_options)

						evict = evict_tenant_menu.list_options
						if evict[1] == "Go back"
							next
						else
							apartment.evict_tenant(evict[1])
						end

					when "Go back"
						break
				end
			end
		when "Add apartment"
			#add apartment
			puts "New apartment:"
			name = gets.chomp.capitalize
			all_apartments << Apartment.new(name)
		when "Remove apartment"
			#remove apartment
			puts "Which apartment would you like to remove?"
			options =  all_apartments.map {|apt| apt.name}

			select_apartment_menu.options = apartment_names << "Go back"

			selected = select_apartment_menu.list_options
			next if selected[1] == "Go back"

			all_apartments.delete_at(selected[0]-1)
			
		when "Quit"
			exit
	end
	
end