def fibonacci_recursive(n)
	return n if (0..1).include? n
	fibonacci_recursive(n-1)+fibonacci_recursive(n-2) if n > 1
end

puts fibonacci_recursive(6)

