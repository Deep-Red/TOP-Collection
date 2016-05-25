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
	@incorrect_guesses = []
	knowledge = Array.new(@word.length, "_")
	play(0, knowledge)
end
end

def choose_word(possible_words, wordcount)
	word_num = rand(wordcount-1)
	@word = possible_words[word_num].downcase.split("")
#	puts @word.inspect
end

def player_guess
	puts "What letter would you like to guess?"
	guess = gets.downcase.chomp
	return guess
end

def evaluate_guess(guess, knowledge)
	r = 0
	@word.each_with_index do |l, i|
		if l == guess
			knowledge[i] = l
			r += 1
		end
	end
	if r == 0 
			@incorrect_guesses.push(guess)
	end
end

def show_gamestate(knowledge)
	man = Array.new(@incorrect_guesses.length, "X")
#	puts man.join("").inspect
	puts knowledge.join(" ")
	puts @incorrect_guesses.join(" ")
end

def gameover?(turn, knowledge)
	if knowledge == @word
		puts "Congratulations, you won!"
		show_gamestate(knowledge)
	elsif @incorrect_guesses.length == 7
		puts "Sorry, you lose."
		show_gamestate(knowledge)
		puts "The word was \n #{@word}"
	else 
		play(turn, knowledge)
	end
end

def play(turn, knowledge)
	turn += 1
	show_gamestate(knowledge)
	evaluate_guess(player_guess, knowledge)
	gameover?(turn, knowledge)
end

Game.new

end