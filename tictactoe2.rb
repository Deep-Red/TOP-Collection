class Board

def initialize()
	@gamestate = Array.new("a","b","c","d","e","f","g","h","i")
	end
end

def horizontal_line()
	puts "-+-+-"
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
	row = (pick.to_f / 3).ceil
	col = (pick % 3) == 0 ? 3 : (pick % 3)
	puts @gamestate[row[col]]
	@gamestate[row[col]] = [piece]
 
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
