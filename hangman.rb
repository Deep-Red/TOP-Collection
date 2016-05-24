class Game

def initialize
	possible_words = []
	dictionary = "5desk.txt"
	wordcount = 0
	File.open(dictionary, "r") do |file|
		file.readlines.each_with_index do |line, idx|
		wordlength = line.chomp.length
		if wordlength > 4 && wordlength < 13
			#puts "#{line.chomp} #{idx} #{wordcount} #{wordlength}"
			possible_words.push(line.chomp)
			wordcount += 1
		end
	end
	choose_word(possible_words, wordcount)
end
end

def choose_word(possible_words, wordcount)
	word_num = rand(wordcount-1)
	@word = possible_words[word_num]
end

def player_guess

end

def evaluate_guess

end

def display_gamestate

end

def gameover?

end



Game.new

end