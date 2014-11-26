require 'colorize'

DIVIDER = "================================".blue

class Menu
	attr_reader :name
	attr_accessor :options

	def initialize(name)
		@name = name
		@options = []
	end

	def add_options(options)
		options.each do |option|
			@options << option
		end
	end

	def remove_options(options)
		@options.delete(options)
	end

	def list_options(title = "")
		return if @options.length == 0

		puts DIVIDER

		puts title if title.length > 0

		begin
			i = 1
			@options.each do |option|
				puts "#{i}. #{option}"
				i += 1
			end

			puts DIVIDER
			
			answer = gets.chomp.to_i

			if answer < 1 || answer > i - 1
				puts "Sorry, that option is unavailable."
				puts DIVIDER
			end
		end while answer < 1 || answer > i - 1
		return [answer, @options[answer - 1]]
	end
end