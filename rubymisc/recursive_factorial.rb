def recursive_factorial(n)
	@fact ||= 1
	return @fact if n == 0
#	puts @fact
	@fact = @fact * n
	n -= 1
	recursive_factorial(n)
end

puts "What number would you like to calculate the factorial of?"
n = gets.chomp.to_i
puts "#{n}! = #{recursive_factorial(n)}"