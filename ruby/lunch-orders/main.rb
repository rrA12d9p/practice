require_relative 'order.rb'
require_relative 'menu.rb'

main_menu = Menu.new("Main Menu")
main_menu.add_options(["View all orders",
											 "Create a new order",
											 "Edit an order",
											 "Delete an order",
											 "Quit"])

order_menu = Menu.new("All Orders")
order_menu.add_options(Order.all.map {|order| order})

while true

	mm_select = main_menu.list_options

	case mm_select[1]
		when "View all orders"
			Order.all.each do |order|
			  p order
			end
		when "Create a new order"
			puts "Name for order:"
		  name = gets.chomp

		  puts "#{name} wants to order:"
		  order = gets.chomp

		  order = Order.create(name: name, order_title: order)
		when "Edit an order"
		when "Delete an order"
			puts "Which order would you like to delete?"
			
			order_menu.options = Order.all.map {|order| order}
			order_del = order_menu.list_options
			del_id =  order_menu.options[order_del[0]-1].id

			Order.find(del_id).delete
		when "Quit"
			exit
	end
end

