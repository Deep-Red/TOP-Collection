def fibs(n)
#	result = 0
#	prevresult = 0
	if n < 1
		return 0 
	elsif n == 1
		return 1
	else
		result = 1
		prevresult = 1
		(n-2).times {
			result, prevresult = (result + prevresult), result
		}
		return result
	end
end

def fibs_rec(n)
	return n if (0..1).include? n
	fibs_rec(n-1) + fibs_rec(n-2) if n > 1
end		

n = 7
puts fibs(n)
puts fibs_rec(n)