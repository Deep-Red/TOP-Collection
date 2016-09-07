class Board
	attr_accessor :square, :grid, :turn

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
	end

	def on_board?(square)
		square.each do |c| 
			if c >= 0 && c <= 7
				true
			else
				false
			end
		end

	end

	def invalid_square_selected
		puts "That square isn't on the board! Try again."
		play_turn
	end

	def name_square
		name_piece = []
		n_p = gets.chomp.split("")
		puts n_p.inspect
		name_piece[1] = n_p[0].downcase.bytes.pop
		name_piece[1] -= 97
		reversing_array = ["Error", 7, 6, 5, 4, 3, 2, 1, 0]
		name_piece[0] = reversing_array[n_p[1].to_i]
		puts name_piece.inspect
		if on_board?(name_piece)
			name_piece  
		else 
			invalid_square_selected
		end
	end

	def play_turn
		from = []
		to = []
		puts "What piece would you like to move?"
		from = name_square
		puts "To where would you like it moved?"
		to = name_square
#		valid_move?
		move_piece(from, to)

	end

	def valid_move?

	end

	def move_piece(from, to)
		tomove = grid[from[0]][from[1]]
		puts tomove.inspect


	end
end

class Piece
	attr_accessor :position, :type, :player, :piece, :icon#, :square_exists

	def initialize(x, y, type, player)
		@position = [x,y]
		@type = type
		@player = player
		@piece = @type.new(@player)
		@icon = @piece.icon
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
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2659" : "\u265F"
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
	attr_accessor :icon, :legal_route
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2655" : "\u265C"
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
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 2 ? "\u2654" : "\u265A"
	end

end

game = Board.new
game.display

game.play_turn
puts "\u2659 \u265F \u2655 \u265C"