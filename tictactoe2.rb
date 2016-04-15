class Board

def initialize()
	@gamestate = Array.new
	3.times do 
		@gamestate.push(["A","B","C"])
	end
end

def horizontal_line()
	puts "-----"
end

def show_gamestate()
	puts @gamestate[0].join "|"
	horizontal_line
	puts @gamestate[1].join "|"
	horizontal_line
	puts @gamestate[2].join "|"
end

def show_board_map()
	puts "1|2|3"
	self.horizontal_line
	puts "4|5|6"
	self.horizontal_line
	puts "7|8|9"
end

def mark(player, choice)
	piece = player == 1 ? "X" : "O"
	pick = choice.to_i
	if pick <= 3
		@gamestate[0[pick - 1]] = [piece]
	elsif pick >= 7
		@gamestate[1[pick - 7]] = [piece]
	else
		@gamestate[2[pick - 4]] = [piece]
	end		
	show_gamestate
end

def play(turn)
	turn += 1
	player = turn % 2 ? 1 : 2

	puts "Turn #{turn}:" 
	puts "It is player #{player}'s turn!"

	show_gamestate
	puts "Which space would you like to choose, Player #{player}?"
	choice = gets.chomp
	mark(player, choice)
end

end


gameboard = Board.new
turn = 0
puts "Welcome to Tic Tac Toe"
puts "Use the following space numbers to choose your move."
gameboard.show_board_map
gameboard.play(turn)
