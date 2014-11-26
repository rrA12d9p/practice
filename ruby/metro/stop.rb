class Stop
	attr_accessor :name, :lines, :connected

	def initialize(name)
		@name = name
		@lines = []
		@connected = []
	end

	def add_line(line)
		@lines << line
	end

	def add_connected(stop)
		@connected << stop
		@connected.uniq!
	end

	def line_names
		return @lines.map {|line| line.name}
	end

	def transfer_station?
		return @lines.length > 1
	end

	def same_line?(stop)
		common_lines = @lines & stop.lines
		return common_lines == nil ? false : common_lines.length > 0
	end

	def direct_transfers_to(metro, stop)
		return nil if same_line?(stop) # throw an error instead?

		# find all the lines for each
		# get all the stops for the lines a and b are on
		a_line_stops = @lines.map { |line| line.stops}.flatten
		b_line_stops = stop.lines.map { |line| line.stops}.flatten

		# find the common stop names
		common_stop_names = a_line_stops & b_line_stops

		common_stops = []
		common_stop_names.each do |stop_name|
			common_stops << metro.stop_by_name(stop_name)
		end
	
		return common_stops
	end

	def stops_to(metro, stop)
		stops = []

		if self.same_line?(stop)
			a_lines = @lines
			b_lines = stop.lines

			a_lines.each do |a_line|
				b_lines.each do |b_line|

					# next if either stop isn't on the other's line
					next if !a_line.stops.include?(stop.name) || !b_line.stops.include?(self.name)

					a_pos = a_line.stop_position(self)
					b_pos = b_line.stop_position(stop)

					stop_count = (b_pos - a_pos).abs

					next if stop_count == 0

					stops << stop_count

					puts "#{self.name} direct to #{stop.name} (#{stop_count})"
				end
			end
		else
			direct_transfers = self.direct_transfers_to(metro, stop)
			
			a_lines = @lines
			b_lines = stop.lines

			# this loop considers every possible transfer for every possible line combination
			a_lines.each do |a_line|
				b_lines.each do |b_line|
					direct_transfers.each do |transfer|

						a_pos = a_line.stop_position(self)
						a_t_pos = a_line.stop_position(transfer)
						b_t_pos = b_line.stop_position(transfer)
						b_pos = b_line.stop_position(stop)

						a_leg = (a_pos - a_t_pos).abs
						b_leg = (b_t_pos - b_pos).abs
						stop_count = (a_leg + b_leg).abs

						stops << stop_count

						puts "#{self.name} to #{stop.name} via #{transfer.name} (#{stop_count})"

					end
				end
			end

			
		end

		return stops.min
	end
end