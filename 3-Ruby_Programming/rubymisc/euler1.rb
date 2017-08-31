puts "We will calculate the sum of multiples of three and five."
puts "What would you like the maximum number set to?"
input = gets.to_f
@fives = 0.0
@fiveround = 0.0
@threes = 0.0
@threeround = 0.0
@fifteens = 0.0
@fifteenround = 0.0
def sum_of_multiples(input)
	val = input - 1
	@fiveround = (val - (val % 5))
	@fives = @fiveround / 5
	@threeround = (val - (val % 3))
	@threes = @threeround / 3
	@fifteenround = (val - (val % 15))
	@fifteens = @fifteenround / 15

	@sumfives = (@fives) * ((@fiveround + 5) / 2)
	@sumthrees = (@threes) * ((@threeround + 3) / 2)
	@sumfifteens = (@fifteens) * ((@fifteenround + 15) /2)

	@sum = (@sumfives + @sumthrees - @sumfifteens).to_i
end

puts sum_of_multiples(input)