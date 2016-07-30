class Board
	def initialize(x = 8)
		board = Array.new(x) { |i| Array.new(x) { |j| [i, j]} }
		
	end
end

class Knight
	attr_accessor :position, :paths, :target, :legal_routes

	def initialize(b, a = [7,1])
		@target = b
		@position = a
		@legal_routes = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
		@paths
	end

	def move
		@position 


	end

	def potential_squares(current = @position)
		current = current
#		puts "YO #{current}"
		moves = []
		temp = []
		@legal_routes.each_with_index { |x, i| temp[i] = [x[0] + current[0], x[1] + current[1]] }
		temp.each do |x| 
			moves << x if valid_square?(x)
		end
		puts moves.inspect
		return moves
	end

	def valid_square?(target)
		a = target[0]
		b = target[1] 
		if a < 8 && a > -1 
			b < 8 && b > -1 ? true : false
		else
			return false
		end
	end

	def find_path(target)
		current = @position
		target = target
		queue = [current]
		visited = [current]

		while queue != []
			if current == target
				return current
			elsif current != nil
				visited << current
				puts "current is #{current}"
				self.potential_squares(current).each{ |x| queue << x }
				current = queue.shift
			else 
				current = queue.shift
			end
		end

	end
end


my_board = Board.new(8)
my_knight = Knight.new([3, 3])
puts "Tracing path from #{my_knight.position.inspect} to #{my_knight.target.inspect}"
#puts my_knight.legal_routes.inspect
#my_knight.potential_squares
my_knight.find_path([4,5])
my_knight.potential_squares([4,5])
my_knight.potential_squares([3,3])
my_knight.potential_squares([7,1])