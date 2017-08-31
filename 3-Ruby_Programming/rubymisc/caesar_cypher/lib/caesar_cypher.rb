def caesar_cypher(text, sd)
	@numerical = text.bytes
	#num_array = numerical.to_s
	#puts num_array

	@numerical.map! do |num| 
		if num > 96 && num < 123 
			num = (((num + sd - 97) % 26) + 97);
		elsif num > 64 && num < 91
			num = (((num + sd - 65) % 26) + 65);
		else num = num
		end
	end
	return @numerical.pack('C*')

end

#puts "Welcome to Caesar Cypher!"
#puts "Enter some text!"
#text = gets.chomp
#puts "How far would you like to shift the characters?"
#sd = gets.chomp.to_i
#caesar_cypher(text, sd)
#puts @numerical
#puts @numerical.pack('C*')