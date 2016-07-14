class Node

	attr_accessor :left, :right, :parent, :value

	def initialize(value, parent = nil, l_child = nil, r_child = nil)
		@value = value
		@parent = parent
		@left = l_child
		@right = r_child
	end

end

class Tree
	attr_accessor :root

	def initialize(array)
		parent = nil
		build_tree(array)
	end

	def build_tree(array) # iterative, assumes sorted list
		item = array.length / 2
		@root = Node.new(array[item])
		last = @root
#		puts array.inspect
#		puts last.value
		array.delete_at(item)
#		puts array.inspect
#		puts last.value
		array.each do |v|
			set = nil
			puts last.value
			if v > last.value 
				if last.right == nil
					last.right = Node.new(v, last)
					last = last.right
					set = true
					puts "one"
				else
					last = last.right
					puts "two"
				end
			else
				if last.left == nil
					last.left = Node.new(v, last)
					last = last.left
					set = true
					puts "three"
				else
					last = last.left
					puts "four"
				end
			end
		end
	end

	def breadth_first_search(target)
		queue = []
		visited = []
		current = @root
		until current == nil
			queue << current
			return current if current.value == target
			return current.right if current.right == target
			return current.left if current.left == target
			visited << current
			current = current.left
		end


	end

	def depth_first_search(target)

	end

	def dfs_rec(target)

	end

	def get_sorted_tree(node = @root, result = [])
		result << "#{node.value}: #{node.left.value if node.left != nil}: #{node.right.value if node.right != nil}!"

		get_sorted_tree(node.left, result) if node.left
		get_sorted_tree(node.right, result) if node.right
		return result
	end

end

my_array = Array(2..15)
puts my_array.inspect
my_tree = Tree.new(my_array)
puts my_tree.get_sorted_tree.inspect