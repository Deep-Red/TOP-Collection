bottles = 99
while bottles > 0
	puts bottles.to_s + " bottles of beer on the wall,"
	puts bottles.to_s + " bottles of beer,"
	puts "take one down, pass it around,"
	bottles -= 1
	puts bottles.to_s + " bottles of beer on the wall!"
	puts " "
end
puts "And we are out of beer!"