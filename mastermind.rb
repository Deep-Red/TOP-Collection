class Gameboard
	require 'colorize'
	@@colormap = ["1".red, "2".yellow, "3".green, "4".cyan, "5".blue, "6".magenta]
	@@colormap2 = ["\e[0;31;49mX\e[0m", "\e[0;33;49mX\e[0m", "\e[0;32;49mX\e[0m", "\e[0;36;49mX\e[0m", "\e[0;34;49mX\e[0m", "\e[0;35;49mX\e[0m"]


def initialize()
	@codekey = Array.new(4, 0)
	@codekey.map!{rand(1..6)}
	puts @codekey
end

def show_gamestate()
	puts @@colormap.join(" ")
#	puts @@colormap.inspect
	puts "\n X X X X \n".black.bold
	puts "\n X X X X \n".black.bold.inspect
	
	
end

#def check_cows(guess_no_b, check_arr, bull_arr, turn, codekey)
#	puts guess_no_b.inspect
#	puts check_arr.inspect
#	#puts codekey
#	#puts guess.inspect
#	#puts "you are here"
#	check_arr.map! { |element| 
#				guess_no_b.include?(element) ? element : nil }
#	puts check_arr.inspect
#	#puts #check_bulls(turn)
#end

def check_bulls(guess, turn)
	codekey = @codekey
	bull_arr = []
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
#	puts bull_arr.inspect
#	check_cows(guess_no_b, check_arr, bull_arr, turn, codekey)
	generate_feedback(bull_arr, codekey, guess)

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

def display_guess(guess)
	dg = []
	guess.each_with_index{|g, i|
	dg[i] = @@colormap2[(g.to_i-1)]
	}
	puts " " + dg.join(" ")
end

def generate_feedback(bull_arr, codekey, guess)
	feedback = codekey
	eval = ["|".red, "|".red, "|".red, "|".red]
	bull_arr.each_with_index{|b, i| 
		if b == "B"
			feedback[i] = @@colormap2[(i.to_i - 1)]
			eval[i] = "|".green
			guess[i] = "O"
#			codekey[i] = "X"
		end
	}
	guess.each_with_index{|g, i|
		if g == feedback.any?
			eval[i] = "|".yellow
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
	display_guess(guess)
	guess.map!{ |x| x.to_i}
	valid_guess?(guess, turn)


end

end

x = Gameboard.new
x.play(0)
