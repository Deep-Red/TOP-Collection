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
	incorrect_guesses = []
	knowledge = [wordcount, "_"]
	play(0, knowledge, incorrect_guesses)
end
end

def choose_word(possible_words, wordcount)
	word_num = rand(wordcount-1)
	@word = possible_words[word_num].downcase
end

def player_guess
	puts "What letter would you like to guess?"
	guess = gets.downcase.chomp
	evaluate_guess(guess)
end

def evaluate_guess
	guess =~ /[[:alpha:]]/ ? true : puts "Invalid guess!" play(turn-1, knowledge, incorrect_guesses) 
end

def show_gamestate(misses, knowledge, incorrect_guesses)
	puts Array.new(misses, "\e[0;31;49mX\e[0m ")
	puts knowledge
	puts incorrect_guesses
end

def gameover?

end

def play(turn, knowledge, incorrect_guesses)
	turn += 1
	show_gamestate(misses, knowledge, incorrect_guesses)
	player_guess

end

Game.new

end