class Node

	attr_accessor :left, :right, :parent, :value

	def initialize(value, parent = nil)
		@value = value
		@parent = parent
		@left = nil
		@right = nil
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
			puts last
			if last == nil || v > last.value 
				if last.right == nil
					last.right = Node.new(v, last)
					set = true
				else
					last = last.right
				end
			else
				if last.left == nil
					last.left = Node.new(v, last)
					set = true
				else
					last = last.left
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
#		result << @root.value
		get_sorted_tree(node.left, result) if node.left
		result << node.value
		get_sorted_tree(node.right, result) if node.right
		return result
	end

end

myarray = [2, 3, 6, 8, 99, 7, 5, 33, 21, 1, 3]
mytree = Tree.new(myarray)
puts mytree.get_sorted_tree.inspect