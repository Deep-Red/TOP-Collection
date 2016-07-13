class LinkedList

attr_reader :head, :tail, :size

def initialize
	@head = nil
	@tail = nil
	@size = 0
end

def append(value)
	new_node = Node.new(value)
	
	if @head.nil?
		@head = new_node
	else 
		@tail.next_node = new_node
	end

	@size += 1
	@tail = new_node

end

def prepend(value)

	if @head.nil?
		append(value)
	else
		new_node = Node.new(value)
		new_node.next_node = @head
		@head = new_node
		@size += 1
	end

end

def size
	@size.value
end

def head
	@head.value
end

def tail
	@tail.value
end

def at(index)
	return nil if index < 0 || index > @size
	if index == 0
		puts @head
	else
		i = index
		here = @head
		until i == 0
			here =  here.next_node
			i -= 1
		end
		here.value
	end
end		

def pop
	@tail = nil
end

def contains?(value)
	temp = @head
	until temp == nil
		if temp == value
			return true
		else 
			temp == temp.next_node
		end
	end
	return false
end


def find(data, temp = @head, i = 0)
	return i if temp = data
	return nil if i > @size
	i += 1
	temp = node.next_node
	find(data, temp, i)
end

def to_s
	temp = @head
	until temp == nil
		print "( #{temp.value} ) => "
		temp = temp.next_node
	end
	puts "nil"
end

def insert_at(index)

end

def remove_at(index)

end

end


class Node
attr_accessor :value, :next_node

def initialize(value = nil)
	value = value
	next_node = nil
end

end

my_list = LinkedList.new
my_list.append(87)
my_list.append(25)

my_list.to_s