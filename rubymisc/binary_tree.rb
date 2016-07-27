class Node

attr_accessor :left, :right, :parent, :value, :count

	def initialize(value, parent = nil, l_child = nil, r_child = nil)
		@value = value
		@parent = parent
		@left = l_child
		@right = r_child
		@count = 1
		puts "#{@value} added as #{self}" #Confirms a node was added to see when exactly the code breaks down.
	end

end

class Tree
	attr_accessor :root

def initialize(array)
	array.shuffle! #Prevents a sorted list from being arranged in a straight line
	puts array.inspect
	@root = Node.new(array.shift)
	array.each { |val| add_node(val) }
end

def add_node(new_node, position = @root)
	case new_node <=> position.value
	when 0 then position.count += 1
	when -1	then position.left.nil? ? position.left = Node.new(new_node) : add_node(new_node, position.left)
	when 1 then	position.right.nil? ? position.right = Node.new(new_node) : add_node(new_node, position.right)
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
	result << "#{node.value} #{node.count if node.count > 1}: #{node.left.value if node.left != nil}: #{node.right.value if node.right != nil}!"
	get_sorted_tree(node.left, result) if node.left
	get_sorted_tree(node.right, result) if node.right
	return result
end

end


my_array = [34, 11, 11, 23, 43, 87, 5, 1, 27, 44, 34, 2, 6, 88, 22, 22, 33, 33, 22, 54, 45, 45, 45, 77, 44, 55, 74, 22, 33, 1, 5, 7, 43]
#my_array = Array(2..15)
puts my_array.inspect
my_tree = Tree.new(my_array)
puts my_tree.get_sorted_tree.inspect