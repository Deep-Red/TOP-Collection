def substring(input, dictionary)
	result = Hash.new(0)
	dictionary.each do |i| 
		input.each do |j|
#			com1 = i.to_s
#			com2 = j.to_s
#			puts com1
#			puts com1.class
#			puts com2
#			puts com2.class
			if com1 == com2
				puts "YES"
				result[j] += 1
			end
		end
	end
	puts result
end
dictionary = ["below","down","going","go","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts "Welcome to the Substring method!"
puts "Enter some text to compare against the dictionary:"
input = [gets.chomp.split];
#puts input
substring(input, dictionary)