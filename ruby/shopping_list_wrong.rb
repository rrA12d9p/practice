class ShoppingList
	attr_writer :items
	attr_accessor :title

	def initialize(title)
		@title = title
		@items = []
	end

	def all_the_items
				return @items
	end

			def title = new_title
		title = new_title
	end

def formatter
	return @items.join(', ')
end

def add_item(new_item)
	items << @new_item
end

		def remove_item(@item)
		if @items.include?(item)
		@items.delete(item)
		end 
		end

		def i'm here but i don't know why
			
		end
end 

while true
	puts "1- Create new shopping list by entering title"
	puts "2- Edit list's title"
	puts "3- See all items"
	puts "4- Add new item"
	puts "5- Remove item"
	puts "6- Exit"
	input = gets.chomp
	#case statement for different options
	case input
	when '1' #Creating a new list
		puts 'Enter title'
		title = gets.chomp
		list = ShoppingList.new(title)
	when '2' #Editing the list's title
		puts 'Enter new title'
		list.title = gets.chomp
		puts list.title
	when '3' #Displaying all the list items
		puts list.formatter
	when '4' #Adding item to the list
		print "Enter item to add: "
		new_item = gets.chomp
		list.add_item(new_item)
		puts "Your new list: #{list.formatter}"
	when '5' #Removing item from the list
		puts "Here are your current list items: #{list.formatter}"
		puts "Want to delete some?(y/n)"
		if gets.chomp == "y"
			puts "Here's the current list: #{list.formatter}" 
			print "Enter item to delete:" 
			item = gets.chomp
			list.remove_item(item)
			puts "Your new list: #{list.formatter}"
		else 
			puts "Here's the current list: #{list.formatter}"
		end 
	when '6'
		puts "Happy shopping!"
		break
	end
end 