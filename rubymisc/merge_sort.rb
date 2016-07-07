def merge_sort(arr, result = [])
	return result = [arr[0] <=> arr[-1]] if arr.length <= 2
	arr_1 = arr[0..(arr.length/2)]
	arr_2 = arr[((arr.length/2)+1)..-1]
	merge_sort(arr_1, result)
	merge_sort(arr_2, result)
	puts arr_1.inspect
	puts arr_2.inspect
	puts "."
	if arr_1[0] <=> arr_2[0]
		result = [arr_2[0], arr_1[0]]
	else
		result = [arr_1[0], arr_2[0]]
	end
	return result if result.length == arr.length
end

puts merge_sort([1, 5, 2, 4, 7, 88, 3, 15])
