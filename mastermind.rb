class Gameboard
	require 'colorize'
	@@colormap = ["1".red, "2".yellow, "3".green, "4".cyan, "5".blue, "6".magenta]


def initialize()
	@codekey = Array.new(4, 0)
	@codekey.map!{rand(1..6)}
	puts @codekey
end

def show_gamestate()
	puts @@colormap.join(" ")
	puts "\n X X X X \n".black.bold
	
	
end

def check_cows(guess_no_b, check_arr, bull_arr, turn, codekey)
	cow_arr = []
	puts guess_no_b.inspect
	puts check_arr.inspect
	#puts codekey
	#puts guess.inspect
	#puts "you are here"
	check_arr.map! { |element| 
				guess_no_b.include?(element) ? element : nil }
	puts check_arr.inspect
	#puts cow_arr
	#check_bulls(cow_arr, turn)
end

def check_bulls(guess, turn)
	codekey = @codekey
	bull_arr = []
	cow_arr = []
	check_arr = guess
	guess_no_b = []
	guess.each_with_index { |g, i| 
		if codekey[i] == guess[i] 
		then bull_arr[i] = "B"
			codekey[i] = ".".black
			guess_no_b[i] = nil
		else guess_no_b[i] = g
			check_arr[i] = nil
		end
	}
	puts bull_arr.inspect
	check_cows(guess_no_b, check_arr, bull_arr, turn, codekey)
	generate_feedback(bull_arr, cow_arr, codekey)

end

def valid_guess?(guess, turn)
	guess.length != 4 ? invalid_guess(guess, turn) :
	check_bulls(guess, turn)
end

def invalid_guess(guess, turn)
	puts "That's not a valid guess!"
	puts "Try again!"
	play(turn - 1)
end

def generate_feedback(bull_arr, cow_arr, codekey)
	feedback = codekey
	eval = []
	bull_arr.each_with_index{|b, i| 
		if b == "B" 
			feedback[i] = "X".black
		else feedback[i] = nil
		end
	}
	puts " " + feedback.join(" ") + (eval.join)
end

def play(turn)
	turn += 1
	puts "Turn #{turn}:"
	show_gamestate
	
	puts "Guess Below:"
	guess = gets.chomp.split("")
	guess.map!{ |x| x.to_i}
	valid_guess?(guess, turn)


end

end

x = Gameboard.new
x.play(0)
