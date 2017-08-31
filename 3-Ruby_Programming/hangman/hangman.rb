require 'csv'

class Game

def initialize
	possible_words = []
	dictionary = "5desk.txt"
	wordcount = 0
	@turn = 0
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
	@knowledge = Array.new(@word.length, "_")
	play
end
end

def save_game
	w = @word.join
	k = @knowledge.join
	i = @incorrect_guesses.join
	CSV.open("savedata.csv", "w") do |file|
		file << ["id", "word", "knowledge", "incorrect_guesses"]
		file << ["0", "#{w}", "#{k}", "#{i}"]
	end
end

def load_game
#	File.open("savedata.txt", "r") do |file|
# 	end
	load_gamestate = CSV.open "savedata.csv", headers: true, header_converters: :symbol
	load_gamestate.each do |row|
	@knowledge = row[:knowledge].split("")
	@word = row[:word].split("")
	@incorrect_guesses = row[:incorrect_guesses].split("")
	play
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
	if guess == "1"
		save_game
		@turn -= 1
		return nil
	elsif guess == "2"
		load_game
	else
		return guess
	end
end

def evaluate_guess(guess)
	r = 0
	@word.each_with_index do |l, i|
		if l == guess
			@knowledge[i] = l
			r += 1
		end
	end
	if r == 0 
			@incorrect_guesses.push(guess)
	end
end

def show_gamestate
	man = Array.new(@incorrect_guesses.length, "X")
#	puts man.join("").inspect
	puts @knowledge.join(" ")
	puts @incorrect_guesses.join(" ")
end

def gameover?
	if @knowledge == @word
		puts "Congratulations, you won!"
		show_gamestate
	elsif @incorrect_guesses.length == 7
		puts "Sorry, you lose."
		show_gamestate
		puts "The word was \n #{@word}"
	else 
		play
	end
end

def play
	@turn += 1
	show_gamestate
	evaluate_guess(player_guess)
	gameover?
end

puts "Welcome to Hangman!"
puts "To save your game at any time enter 1"
puts "To load a saved game enter 2"
Game.new

end