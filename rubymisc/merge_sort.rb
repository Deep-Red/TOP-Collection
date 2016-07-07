def merge_sort(arr, result = [])
	return if arr.length <= 1
	arr_1 = arr[0..(arr.length/2)]
	arr_2 = arr[((arr.length/2)+1)..-1]
	puts arr_1.inspect
	puts arr_2.inspect
	puts result.inspect
	puts "."
	
	result << arr_1.each.find { |a| arr_2.include? { |b| b < a }
	return result if result.length == arr.length
end

puts merge_sort([5, 1, 2, 4, 7, 88, 3, 15])
