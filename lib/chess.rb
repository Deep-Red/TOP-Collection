class Board
	attr_accessor :square, :grid, :turn, :captured, :check, :mate

	def initialize
		@grid = Array.new(8){ |i|
			i = Array.new(8){ |j|
				j = nil
			} }
#		puts @grid[0].inspect
		@grid[6].map! { |i| i = Piece.new(i, 6, Pawn, 1) }
		@grid[1].map! { |i| i = Piece.new(i, 1, Pawn, 2) }
		@grid[7][0] = Piece.new(7, 0, Rook, 1)
		@grid[7][7] = Piece.new(7, 7, Rook, 1)
		@grid[0][0] = Piece.new(0, 0, Rook, 2)
		@grid[0][7] = Piece.new(0, 7, Rook, 2)
		@grid[7][1] = Piece.new(7, 1, Knight, 1)
		@grid[7][6] = Piece.new(7, 6, Knight, 1)
		@grid[0][1] = Piece.new(0, 1, Knight, 2)
		@grid[0][6] = Piece.new(0, 6, Knight, 2)
		@grid[7][2] = Piece.new(7, 2, Bishop, 1)
		@grid[7][5] = Piece.new(7, 5, Bishop, 1)
		@grid[0][2] = Piece.new(0, 2, Bishop, 2)
		@grid[0][5] = Piece.new(0, 5, Bishop, 2)
		@grid[7][3] = Piece.new(7, 3, Queen, 1)
		@grid[0][3] = Piece.new(0, 3, Queen, 2)
		@grid[7][4] = Piece.new(7, 4, King, 1)
		@grid[0][4] = Piece.new(0, 4, King, 2)

#		puts @grid[0].inspect

		@turn = 0
		@captured = []
		@check = 0
		@mate = 0
	end

	def display
		disp = []
		@grid.each{|i| i.each {|j| j == nil ? disp << "_" : disp << j.icon }}
		puts "   a  b  c  d  e  f  g  h  "
		puts "8  #{disp[0..7].join("  ")}"
		puts "7  #{disp[8..15].join("  ")}"
		puts "6  #{disp[16..23].join("  ")}"
		puts "5  #{disp[24..31].join("  ")}"
		puts "4  #{disp[32..39].join("  ")}"
		puts "3  #{disp[40..47].join("  ")}"
		puts "2  #{disp[48..55].join("  ")}"
		puts "1  #{disp[56..63].join("  ")}"
		puts ""
		puts "Captured pieces: #{captured}"
	end

	def is_piece?(square)
		false if square[0].nil?
		false if square[1].nil?
		grid[square[0]][square[1]] == nil ? false : true
	end

	def on_board?(square)
		if square[0] == nil || square[1] == nil
			return false
		elsif square[0].between?(0,7) && square[1].between?(0,7) 
			return true 
		else 
			return false
		end
	end

	def invalid_square_selected
		puts "That square isn't on the board! Try again."
		@turn -= 1
		play_turn
	end

	def empty_square_selected
		puts "You picked a square without a piece on it,"
		puts "let's try again."
		@turn -= 1
		play_turn
	end

	def illegal_move(from)
		puts "That isn't a legal move for #{grid[from[0]][from[1]]}!"
		puts "Let's try again."
		@turn -= 1
		play_turn
	end

	def name_square
		name_piece = []
		n_p = gets.chomp.split("")
#		puts n_p.inspect
		name_piece[1] = n_p[0].downcase.bytes.pop
		name_piece[1] -= 97
		reversing_array = [7, 6, 5, 4, 3, 2, 1, 0]
		name_piece[0] = reversing_array[n_p[1].to_i - 1]
		puts name_piece.inspect
		name_piece
	end

	def play_turn
		@turn += 1
		from = []
		to = []
		puts "What piece would you like to move?"
		from = name_square
		puts "To where would you like it moved?"
		to = name_square
		if is_piece?(from)
			if on_board?(to)
				legal_route?(from, to) ? move_piece(from, to) : illegal_move(from)
			else
				empty_square_selected
			end
		else
			invalid_square_selected
		end

	end

	def in_file?(from, to)
		from[0] - to[0] == 0 ? true : false
	end

	def in_rank?(from, to)
		from[1] - to[1] == 0 ? true : false
	end

	def on_diagonal?(from, to)
		file = from[0] - to[0]
		rank = from[1] - to[1]
		file == rank ? true : false
	end

	def knight_move?(from, to)
		legal_routes = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
		move_route = []
		puts "hi!"
		puts move_route
		move_route[0] = to[0] - from[0]
		move_route[1] = to[1] - from[1]
		puts move_route
		legal_routes.include? move_route ? true : false
	end

	def only_one_step?(from, to)
		file = from[0] - to[0]
		rank = from[1] - to[0]
		file.between?(-1,1) && rank.between?(-1,1) ? true : false
	end

	def legal_route?(from, to)
		piece = grid[from[0]][from[1]]
		case 
		when piece.type == Rook
			in_rank?(from, to) ^ in_file?(from, to) ? true : false
		when piece.type == Knight
			knight_move?(from, to) ? true : false
		when piece.type == Bishop
			on_diagonal?(from, to) ? true : false
		when piece.type == Queen
			on_diagonal?(from, to) || in_file?(from, to) || in_rank?(from, to) ? true : false
		when piece.type == King
			if only_one_step?(from, to)
				on_diagonal?(from, to) || in_file?(from, to) || in_rank?(from, to) ? true : false
			else
				false
			end
		when piece.type == Pawn
			pawn_move?(from, to) ? true : false
		end
	end

	def move_piece(from, to)
		tomove = grid[from[0]][from[1]]
#		puts tomove.inspect
		grid[from[0]][from[1]].special_move_eligible = false 
#		puts tomove.inspect
		destination = grid[to[0]][to[1]]
		captured << destination if destination != nil
		grid[to[0]][to[1]] = tomove
		grid[from[0]][from[1]] = nil
		display
	end
end

class Piece
	attr_accessor :position, :type, :player, :piece, :icon, :special_move_eligible #, :square_exists

	def initialize(x, y, type, player)
		@position = [x,y]
		@type = type
		@player = player
		@piece = @type.new(@player)
		@icon = @piece.icon
		@special_move_eligible = true
	end

#	def move
#		self.square_exists?
#		self.type.legal_routes
#	end

#	def square_exists?(destination)
#		8 >= destination[0] && destination[0] >= 0 ? true : false
#		8 >= destination[1] && destination[1] >= 0 ? true : false
#	end
end

class Pawn < Piece
	attr_accessor :icon#, :en_passant_eligible
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2659" : "\u265F"
#		@en_passant_eligible = true
	end

	def legal_routes
		if @player == 1
			[[1, 1], [-1, 1]]
		else
			[[1, -1], [-1, -1]]
		end
	end
end

class Rook < Piece
	attr_accessor :icon, :legal_route#, :castling_eligible
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2655" : "\u265C"
#		@castling_eligible = true
	end

	def legal_route(destination)
		if destination[0] == self.position[0] && destination[1] == self.position[1]
			return false
		elsif destination[0] != self.position[0] && destination[1] != self.position[1]
			return false
		else 
			return true
		end
	end
end

class Knight < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2658" : "\u265E"
	end

end

class Bishop < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2657" : "\u265D"
	end

end

class Queen < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2655" : "\u265B"
	end

end

class King < Piece
	attr_accessor :icon#, :castling_eligible
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2654" : "\u265A"
#		@castling_eligible = true
	end

end

game = Board.new
game.display

game.play_turn
#puts "\u2659 \u265F \u2655 \u265C"