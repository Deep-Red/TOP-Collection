roman_mapping = {1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C", 90 => "XC", 50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I"}


def fibonacci_recursive(n)
	return n if (0..1).include? n
	fibonacci_recursive(n-1)+fibonacci_recursive(n-2) if n > 1
end

def arr_flat(arr, result = [])
	arr.each do |r|
		if r.kind_of?(Array)
			arr_flat(r, result) 
		else
			result << r
		end
	end
result
end

def integer_to_roman(roman_mapping, i, result = "")
	return result if i == 0
	roman_mapping.keys.each do |divisor|
		quotient, modulus = i.divmod(divisor)
		result << roman_mapping[divisor] * quotient
		return integer_to_roman(roman_mapping, modulus, result) if quotient > 0
	end
end

def roman_to_integer(roman_mapping, r, result = 0)
	return result if r == ""
	roman_mapping.values.each do |roman|
		if r.start_with?(roman)
			result += roman_mapping.key(roman)
			r = r.slice(roman.length, r.length)
			return roman_to_integer(roman_mapping, r, result)
		end
	end
end


puts fibonacci_recursive(6)
puts arr_flat([[1,[8,9]],[3,4]]).inspect
puts arr_flat([1,2],[3,4]).inspect
puts integer_to_roman(roman_mapping, 57)
puts roman_to_integer(roman_mapping, "LVIII")