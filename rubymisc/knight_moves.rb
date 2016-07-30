class Board
	def initialize(x = 8)
		board = Array.new(x) { |i| Array.new(x) { |j| [i, j]} }
		
	end
end

class Knight
	def initialize(position = [7,1])
		@position = position
	end

	def move
		@position 

	end

	def potential_suares(@position)

	end

	def valid_square?(target)
		target.each{ |x| (0..7).include?(x)} ? return true : return false
	end

	def find_path(position = @position, target)

	end
end


my_board =Board.new(8)

