def fib(max, a = [])
	if a[-1] == nil
		a << 0
	elsif a[-1] == 0
		a << 1
	else
		a << (a[-1] + a[-2])
	end

	if a[-1] >= max
		return a
	else
		fib(max, a)
	end
end

def isfib?(n)
	return fib(n).include?(n)
end

puts isfib?(50)