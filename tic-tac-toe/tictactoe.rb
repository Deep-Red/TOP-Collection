class Board

WINS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[2,5,8],[1,4,7],[0,4,8],[2,4,6]]

def initialize()
	@gamestate = Array.new(9, " ")
end

def horizontal_line()
	dash = "\u2014"
	dn = dash.encode('utf-8')
	puts "#{dn}+#{dn}+#{dn}"
end

def show_gamestate()
	puts @gamestate[0..2].join "|"
	horizontal_line
	puts @gamestate[3..5].join "|"
	horizontal_line
	puts @gamestate[6..8].join "|"
end

def show_board_map()
	puts "1|2|3"
	horizontal_line
	puts "4|5|6"
	horizontal_line
	puts "7|8|9"
end

def winner

end
def mark(player, choice)
	piece = player == 1 ? "X" : "O"
	pick = (choice.to_i - 1)
	@gamestate[pick] = [piece]
end

def game_over_check(player, turn, choice)
	pick = choice.to_i
	if WINS.any? { |line|
		comp_arr = []
		line.each { |spot|
		comp_arr << @gamestate[spot]
		}
		if comp_arr.inspect == '[["X"], ["X"], ["X"]]' || comp_arr.inspect == '[["O"], ["O"], ["O"]]'
			puts "Player #{player} Wins!"
			return true
		end
		}
	then
		return true
	elsif turn == 9
		return true
	else
		return false
	end
end

def goodbye
	puts "This game is over."
end

def play(turn)
	game_over = 0
	turn += 1
	player = (turn % 2) == 1 ? 1 : 2

	puts "Turn #{turn}:"
	puts "It is player #{player}'s turn!"

	show_gamestate
	puts "Which space would you like to choose, Player #{player}?"
	choice = gets.chomp
	mark(player, choice)
	show_gamestate
	game_over_check(player, turn, choice) ? goodbye : play(turn)

end

end

gameboard = Board.new
turn = 0
winner = 0
puts "Welcome to Tic Tac Toe"
puts "Use the following numbers to choose your move."
gameboard.show_board_map
gameboard.play(turn)
