Class Row
def initialize(rownum)
	@rownum = rownum
	@val = [nil,nil,nil]
end

def mark(player, choice)
	piece = player == 1 ? "X" : "O"
	if choice <= 3
		1[choice - 1] = piece
	elsif choice >= 7
		2[choice - 7] = piece
	else
		3[choice - 4] = piece
	end			
end

def display_row(rownum)
 	@rownum.join("|")
end
end


turn = 0
winner = 0

def show_board()
	display_row(1)
	display_row(2)
	display_row(3)
end

def show_board_map()
	puts "1|2|3"
	puts "-----"
	puts "4|5|6"
	puts "-----"
	puts "7|8|9"
end

def play(turn)
	turn += 1
	player = turn % 2 ? 1 : 2

	puts "Turn #{turn}:" 
	puts "It is player #{player}'s turn!"

	show_board
	puts "Which space would you like to choose, Player #{player}?"
	choice = gets.chomp
	mark(player, choice)
end


puts "Welcome to Tic Tac Toe"
puts "Use the following space numbers to choose your move."
show_board_map
play(turn)
