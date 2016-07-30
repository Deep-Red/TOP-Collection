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
		temp = []
		@paths.each_with_index { |x, i| temp[i] = [x[0] + @position[0], x[1] + @position[1]] }

		puts temp.inspect
		temp.each do |x| 
			moves << x if valid_square?(x)
		end


		puts moves.inspect
	end

	def valid_square?(target)
		puts target.inspect
		a = target[0]
		b = target[1] 
		if a < 8 && a > -1 
			puts "hi"
			b < 8 && b > -1 ? true : false
		else
			return false
		end
	end

	def find_path(position = @position, target)

	end
end


my_board = Board.new(8)
my_knight = Knight.new()
puts my_knight.position.inspect
puts my_knight.paths.inspect
my_knight.potential_squares
