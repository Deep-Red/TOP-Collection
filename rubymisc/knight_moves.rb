class Board
	def initialize(x = 8)
		board = Array.new(x) { |i| Array.new(x) { |j| [i, j]} }
		
	end
end

class Knight
	attr_accessor :position, :paths

	def initialize(position = [7,1])
		@position = position
		@paths = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
	end

	def move
		@position 


	end

	def potential_squares()
		moves = []
		@paths.each_with_index { |x, i| moves[i] = [x[0] + @position[0], x[1] + @position[1]] }

		puts moves.inspect
		moves = moves.each { |x| valid_square?(x) }
		puts moves.inspect
	end

	def valid_square?(target)
		puts target.inspect
		target.each{ |x| x < 8 && x > -1 }
			puts "hi"
			return target 
		else
			return nil
		end
	end

	def find_path(position = @position, target)

	end
end


my_board = Board.new(8)
my_knight = Knight.new([0,0])
puts my_knight.position.inspect
puts my_knight.paths.inspect
my_knight.potential_squares
