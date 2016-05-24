dictionary = "5desk.txt"

File.open(dictionary, "r") do |file|
	file.readlines.each_with_index do |line, idx|
		puts "#{line.chomp} #{idx} #{line.length}"
	end
end