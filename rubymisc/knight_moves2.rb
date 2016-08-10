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
			if current.coord == target
				display_path(current) 
				exit
			else
			potential_squares(current).each do |x|
				visited.include?(x.coord) ? next : queue << x
			end
			visited << current.coord
			current = queue.shift

#			puts queue.inspect
			end
		end
	end

	def display_path(dest)
		path = [dest]
		current = dest
		while current != @position
#			puts "WAAA"
			current = current.parent
			path.unshift current
		end
		puts "The following moves will get your knight from its current position (#{@position.coord.inspect}) to the target square (#{dest.coord.inspect})."
		path.each {|x| puts x.coord.inspect }
	end


end

my_knight = Knight.new([1, 2])
puts my_knight.find_path([0, 7])



