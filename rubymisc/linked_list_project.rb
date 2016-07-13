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
	@size
end

def head
	@head
end

def tail
	@tail
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
		here
	end
end		

def pop
	@size -= 1
	i = @size
	temp = @head
	(i-1).times do 
		temp = temp.next_node
	end
	temp.next_node = nil

end

def contains?(value, temp = @head)
	until temp == nil
		if temp.value == value
			return true
		else 
			temp = temp.next_node
			contains?(value, temp)
		end
	end
	return false
end


def find(data, temp = @head, i = 0)
	return "#{data} is located at index #{i}." if temp.value == data
	return "#{data} not found in list." if i >= (@size - 1)
	i += 1
	temp = temp.next_node
	find(data, temp, i)
end

def display_list
	temp = @head
	until temp == nil
		print "( #{temp.value.inspect} ) => "
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

def initialize(value)
	@value = value
	next_node = nil
end

def name
	value
end

end

my_list = LinkedList.new
my_list.append(87)
my_list.append(25)
my_list.append(7)
my_list.append(5)
my_list.append(8)
my_list.prepend(2)
puts my_list.size
my_list.display_list
my_list.pop
my_list.display_list
puts my_list.size
puts my_list.find(8)
puts my_list.find(2)
puts my_list.find(25)
puts my_list.contains?(8)
puts my_list.contains?(2)
puts my_list.contains?(25)