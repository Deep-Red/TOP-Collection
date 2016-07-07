def merge_sort(arr)
	return arr if arr.length == 1
	arr_1 = arr[0..((arr.length/2)-1)]
	arr_2 = arr[((arr.length/2))..-1]
#	merge(arr_1, arr_2) if arr_1.length <= 1 && arr_2.length <= 1
#	puts arr_1.inspect
#	puts arr_2.inspect
#	puts result.inspect
# 	puts "."
	
	merge(merge_sort(arr_1), merge_sort(arr_2))
#	return result if result.length == arr.length
end

def merge(arr_1, arr_2)
#	puts "Hi"
	puts arr_1.inspect
	puts arr_2.inspect
	result = []
	until arr_1.length == 0 || arr_2.length == 0
		result << (arr_1[0] <= arr_2[0] ? arr_1.shift : arr_2.shift)
	end
	result + arr_1 + arr_2
#	puts result.inspect
#	return result
end


puts merge_sort(["hi", "i", "am", "a", "list", "of", "terms", "87", "to", "3", "23", "be", "sorted", "9", "11"]).inspect
