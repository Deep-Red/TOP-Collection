class Game

def initialize
	dictionary = "5desk.txt"
	wordcount = 0
	File.open(dictionary, "r") do |file|
		file.readlines.each_with_index do |line, idx|
		wordlength = line.chomp.length
		if wordlength > 3 && wordlength < 13
			puts "#{line.chomp} #{idx} #{wordcount} #{wordlength}"
			wordcount += 1
		end
	end
end
end

Game.new

end