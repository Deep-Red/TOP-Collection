class Node
	attr_accessor :coord, :parent, :children

	def initialize(coord, parent = nil, children = nil)
		@coord = coord
		@parent = parent
		@children = children		
	end
end

class Knight
	attr_accessor :position, :paths, :target, :legal_routes

	def initialize(a = [7,1])
		@position = Node.new(a)
		@legal_routes = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
		@paths
	end

	def move
		@position 


	end

	def potential_squares(current = @position.coord)
		current = current
		puts "YO #{current}"
		moves = []
		temp = []
		@legal_routes.each_with_index { |x, i| temp[i] = [x[0] + current[0], x[1] + current[1]] }
		temp.each do |x| 
			moves << x if valid_square?(x)
		end
#		puts moves.inspect
		moves.each{ |ns| Node.new(ns, current)}
		position.children = moves
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

#	def find_path(target, current = @position)
#		current = current
#		target = target
#		queue = [current]
#		visited = [current]
#		path = []
#		puts "Tracing path from #{current.inspect} to #{target.inspect}"
#
#
#		while queue != []
#			if current == target
#				path << current.unshift
#				return path
#			elsif current != nil
#				visited << current
##				puts "current is #{current}"
#				self.potential_squares(current).each{ |x| queue << x }
#				current = queue.shift
#			else 
#				current = queue.shift
#			end
#		end
#	end

#	def find_path(target, start = @position)
#		position = start
#		queue = position
#		target = target
#
#		queue.unshift(position)
#
#		until position == target
#			self.potential_squares(current).each{ |x| queue << x }
#			position == queue.unshift
#		end
#	end

	def find_path(to, from = @coord)
		target = to
		current = from
		queue = from
		visited = from

		while queue != []
			return current if current == target
			queue << potential_squares(current)
			puts queue
		end



	end

end


my_knight = Knight.new([3, 3])
#puts my_knight.find_path([7,1])

puts my_knight.legal_routes.inspect
puts my_knight.potential_squares.inspect
my_knight.find_path([3, 2])

