class Stop
	attr_accessor :name, :lines

	def initialize(name)
		@name = name
		@lines = []
	end

	def add_line(line)
		@lines << line
	end

	def line_names
		return @lines.map {|line| line.name}
	end

	def transfer_station?
		return @lines.length > 1
	end

	def same_line?(stop)
		common_lines = @lines & stop.lines
		return common_lines == nil ? 0 : common_lines.length > 0
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
			line = @lines[0]
			a_pos = line.stop_position(self)
			b_pos = line.stop_position(stop)
			stops << (b_pos - a_pos).abs
		else
			direct_transfers = self.direct_transfers_to(metro, stop)
			
			a_lines = @lines
			b_lines = stop.lines

			# this loop considers every possible transfer for every possible line combination
			a_lines.each do |a_line|
				b_lines.each do |b_line|
					direct_transfers.each do |transfer|

						next if direct_transfers.length == 0

						a_pos = a_line.stop_position(self)
						a_t_pos = a_line.stop_position(transfer)
						b_t_pos = b_line.stop_position(transfer)
						b_pos = b_line.stop_position(stop)

						a_leg = (a_pos - a_t_pos).abs
						b_leg = (b_t_pos - b_pos).abs

						stops << (a_leg + b_leg).abs

					end
				end
			end

			
		end

		return stops.min
	end
end