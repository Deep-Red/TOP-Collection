class Node
	attr_accessor :coord, :parent, :children

	def initialize(coord, parent = nil)
		@coord = coord
		@parent = parent
		@children = nil
	end
end

class Knight
	attr_accessor :position, :target, :legal_routes

	def initialize(a = [7,1])
		@position = Node.new(a)
		@legal_routes = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
	end

	def potential_squares(from = @position)
		from = from
		fromc = from.coord
		moves = []
		temp = []
		@legal_routes.each_with_index{ |x, i| temp[i] = [x[0] + fromc[0], x[1] + fromc[1]] }
		temp.each { |x| moves << Node.new(x, from) if valid_square?(x) }
#		puts moves.inspect
		return moves
#		moves.each do |x|
#			if x != nil
#				from.children << x
#			end
#		end
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

	def find_path(to)
#		puts "hi"
		target = to
		current = @position
		queue = []
		visited = []
		queue << current
		visited << current.coord
#		puts "yolo"
		while queue != []
#			puts "you know #{current}"
			return current if current == target
			potential_squares(current).each do |x|
				visited.include?(x.coord) ? break : queue << x
			end
			visited << current.coord
			current = queue.shift

#			puts queue.inspect
		end
	end

end

my_knight = Knight.new([1, 2])
my_knight.find_path([2, 2])



