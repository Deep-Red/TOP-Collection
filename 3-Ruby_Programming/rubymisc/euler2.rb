@current = 1
@prev = 1

@total = 0

def iseven(number)
	return number if number % 2 == 0
end

def calcfib(input)
	@current = input
	while @current < input do
	@current += @prev
	@prev = @current - @prev
	@total += @current.iseven
end
end

puts "Let's calculate the sum of all even Fibonaci numbers up to a certain limit."
puts "What would you like that limit to be?"
input = gets.to_i
puts input
puts @current
puts @prev
puts @total
