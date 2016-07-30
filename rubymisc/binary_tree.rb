class Node

attr_accessor :left, :right, :parent, :value, :count

	def initialize(value, parent = nil, l_child = nil, r_child = nil)
		@value = value
		@parent = parent
		@left = l_child
		@right = r_child
		@count = 1
	end

end

class Tree
	attr_accessor :root

def initialize(array)
	array.shuffle! #Prevents a sorted list from being arranged in a straight line
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
	current = @root
	queue = [current]
	visited = [current]
	while queue != []
		if current.value == target
			return current
		else
			visited << current
			queue << current.right if current.right != nil
			queue << current.left if current.left != nil
			current = queue.shift
		end
	end
end

def depth_first_search(target)
	current = @root
	stack = [current]
	visited = [current]
	while current != nil
		if current.value == target
			return current
		elsif current.left && !visited.include?(current.left)
			stack << current.left
			visited << current.left
			current = current.left
		elsif current.right && !visited.include?(current.right)  
			stack << current.right
			visited << current.right
			current = current.right
		else
			current = stack.pop
		end
	end
end

def dfs_rec(target, current = @root)
	return current if target == current.value
	left = dfs_rec(target, current.left) if current.left
	return left if left
	right = dfs_rec(target, current.right) if current.right
	return right if right
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
#my_array = Array(20..26)
puts my_array.inspect
my_tree = Tree.new(my_array)
puts my_tree.get_sorted_tree.inspect
puts my_tree.breadth_first_search(23)
puts my_tree.depth_first_search(27)
puts my_tree.dfs_rec(23)
puts my_tree.dfs_rec(332)
puts my_tree.dfs_rec(87)