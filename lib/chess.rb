class Board
	attr_accessor :square

	def initialize
		@grid = Array.new(8){ |i|
			i = Array.new(8){ |j|
				j = nil
			} }
#		puts @grid[0].inspect
		@grid[1].map! { |i| i = Piece.new(i, 0, Pawn, 1) }
		@grid[6].map! { |i| i = Piece.new(i, 7, Pawn, 2) }
		@grid[0][0] = Piece.new(0, 0, Rook, 1)
		@grid[0][7] = Piece.new(0, 7, Rook, 1)
		@grid[7][0] = Piece.new(7, 0, Rook, 2)
		@grid[7][7] = Piece.new(7, 7, Rook, 2)
		@grid[0][1] = Piece.new(0, 1, Knight, 1)
		@grid[0][6] = Piece.new(0, 6, Knight, 1)
		@grid[7][1] = Piece.new(7, 1, Knight, 2)
		@grid[7][6] = Piece.new(7, 6, Knight, 2)
		@grid[0][2] = Piece.new(0, 2, Bishop, 1)
		@grid[0][5] = Piece.new(0, 5, Bishop, 1)
		@grid[7][2] = Piece.new(7, 2, Bishop, 2)
		@grid[7][5] = Piece.new(7, 5, Bishop, 2)
		@grid[0][3] = Piece.new(0, 3, Queen, 1)
		@grid[7][3] = Piece.new(7, 3, Queen, 2)
		@grid[0][4] = Piece.new(0, 4, King, 1)
		@grid[7][4] = Piece.new(7, 4, King, 2)

#		puts @grid[0].inspect
	end

	def display
		disp = []
		@grid.each{|i| i.each {|j| j == nil ? disp << "_" : disp << j.icon }}
		puts disp[0..7].inspect
		puts disp[8..15].inspect
		puts disp[16..23].inspect
		puts disp[24..31].inspect
		puts disp[32..39].inspect
		puts disp[40..47].inspect
		puts disp[48..55].inspect
		puts disp[56..63].inspect
	end
end


class Piece
	attr_accessor :position, :type, :player, :piece, :icon

	def initialize(x, y, type, player)
		@position = [x,y]
		@type = type
		@player = player
		@piece = @type.new(@player)
		@icon = @piece.icon
	end
end

class Pawn < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 1 ? "\u2659" : "\u265F"
	end
end

class Rook < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 1 ? "\u2655" : "\u265C"
	end
end

class Knight < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 1 ? "\u2658" : "\u265E"
	end

end

class Bishop < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 1 ? "\u2657" : "\u265D"
	end

end

class Queen < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 1 ? "\u2655" : "\u265B"
	end

end

class King < Piece
	attr_accessor :icon
	def initialize(player)
		@player = player
		@icon = @player == 1 ? "\u2654" : "\u265A"
	end

end

game = Board.new
game.display
puts "\u2659 \u265F \u2655 \u265C"