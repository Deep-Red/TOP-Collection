class Gameboard
	@@colormap = ["\e[0;31;49m1\e[0m", "\e[0;33;49m2\e[0m", "\e[0;32;49m3\e[0m", "\e[0;36;49m4\e[0m", "\e[0;34;49m5\e[0m", "\e[0;35;49m6\e[0m"]
	@@colormap2 = ["\e[0;31;49mX\e[0m", "\e[0;33;49mX\e[0m", "\e[0;32;49mX\e[0m", "\e[0;36;49mX\e[0m", "\e[0;34;49mX\e[0m", "\e[0;35;49mX\e[0m"]

def initialize()
	@codekey = Array.new(4, 0)
	@codekey.map!{rand(1..6)}
	puts @codekey.inspect
end

def show_gamestate()
	puts @@colormap.join(" ")
	puts "\e[1;30;49m\n X X X X \n\e[0m"
end

def evaluate_guess(guess, turn)
	feedback = @codekey
	feedbacktemp = feedback
	puts @codekey.inspect
	puts feedback.inspect
	puts feedbacktemp.inspect
	pegs = ["\e[0;31;49m|\e[0m", "\e[0;31;49m|\e[0m", "\e[0;31;49m|\e[0m", "\e[0;31;49m|\e[0m"]

	feedback.each_with_index{|f, i|
		if feedback[i] == guess[i]
			pegs[i] = "\e[0;32;49m|\e[0m"
			feedback[i] = "#{rand()}" #eliminates bulls from feedback
#			guess[i] = "#{rand()}"
		end
	}

#	puts feedback.inspect + " " + pegs.join("")

	guess.each_with_index{|f, i|
		feedback.find_index{ |c|
			if c == f
			pegs[i] = "\e[0;33;49m|\e[0m"
			feedback[c.to_i] = "#{rand()}"
			feedback[i] = "#{rand()}"
			feedbacktemp[i] = "#{rand()}"
		end }
		}

	evaluate_return = "#{display_guess(guess)}" + " " + pegs.join("")
	puts evaluate_return
	play(turn)
end

def valid_guess?(guess, turn)
	guess.length != 4 ? invalid_guess(guess, turn) : 
	evaluate_guess(guess, turn)
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
	print " " + dg.join(" ")
end


def play(turn)
	turn += 1
	puts "Turn #{turn}:"
	show_gamestate
	puts "Guess Below:"
	guess = gets.chomp.split("")
	display_guess(guess)
	puts ""
	guess.map!{ |x| x.to_i}
	valid_guess?(guess, turn)
end

end

x = Gameboard.new
x.play(0)