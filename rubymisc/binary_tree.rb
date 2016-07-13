def class Node

	attr_accessor :left, :right, :parent, :value

	def initialize(value, parent = nil)
		@value = value
		@parent = parent
		@left = nil
		@right = nil
	end

	def 

end

def class Tree
	attr_accessor :root

	def initialize(array)
		parent = nil
		build_tree(array)
	end

	def build_tree(array) # iterative, assumes sorted list
		item = array.length / 2
		@root = Node.new(array[item])
		last = @root
		array.delete_at(item)
		array.each do |value|
			set = nil
			if value > last.value
				if last.right = nil
					last.right = Node.new(value, last)
					set = true
				else
					last = last.right
				end
			else
				if last.left == nil
					last.left = Node.new(value, last)
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
			queue << current.left
				

	end

	def depth_first_search(target)

	end

	def dfs_rec(target)

	end

	def get_sorted_tree(node = @root, result = [])
		get_sorted_tree(node.left, result) if node.left
		result << node.value
		get_sorted_tree(node.right, result) if node.right
		return result
	end

end
