def printTriangle(character, total_rows, backwards = false, full = true)
	if !backwards
		current_row = 0
		row_size = 1
		x = 1
	else
		current_row = total_rows
		row_size = total_rows * 2 - 1
		x = -1
	end

	total_rows.times do |i|
		if !backwards
			row_indent = total_rows - current_row
		else
			row_indent = total_rows - current_row - 1
		end

		current_row += x * 1

		row_indent.times do
			print " "
		end
		row_size.times do |j|
			if full
				print character
			else
				if j == 0 || j == row_size - 1 || current_row == total_rows || i == 0
					print character
				else
					print " "
				end
			end
		end

		row_size += x * 2

		print "\n"
	end
end

printTriangle("#", 10, false, true)