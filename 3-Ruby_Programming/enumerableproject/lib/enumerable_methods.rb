module Enumerable

def my_each
	for i in self
		yield(self[i])
	end

end

def my_each_with_index
	for i in 0...length
		yield(self[i], i)
	end

end

def my_select
	result = []
	my_each {|i| result << if yield(incl) }
	result
end

def my_all?
	my_each {|incl| return false unless yeild(incl)}
end

def my_any?
	my_each {|incl| return true if yeild(incl)}
end

def my_none?
	my_each {|incl| return false if yeild(incl)}
end

def my_count
	count = 0
	my_each {|i| yeild(i) ? count += 1 : count += 0}
end

def my_map(code_block)
	new_array = []
	my_each{|i| new_array << code_block.call(i)}

end

def my_inject(num = nil)
	accumulator = num.nil ? first : num
	my_each {|i| accumulator += yeild(accumulator, i)}
end

def multipy_els(list)
	list.my_inject(1) {|product, i| product * i}
end

end