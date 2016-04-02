puts "Enter a starting year:"
start = gets.to_i
puts "Enter an ending year:"
stop = gets.to_i
time = start
puts ""
puts "The leap years during your chosen time period are:"

while time <= stop
	if time % 4 != 0
		time += 1
	elsif time % 100 == 0
		if time % 400 == 0
			puts time
			time += 1
		else 
			time += 1
		end
	else
		puts time
		time += 1
	end
end
		
