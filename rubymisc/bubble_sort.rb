def bubble_sort(xar)
	xar[0...-1].each_with_index{|val, key| 
		i = 0
		xv1 = xar[key]
		xv2 = xar[key+1]
		xk1 = key
		xk2 = key+1

		if xv1 > xv2
			xar[key] = xv2
			xar[key+1] = xv1
			i+=1
		end
		puts " "
		print xar
bubble_sort(xar) if i > 0
}
end

bubble_sort([4,3,78,2,0,2])

def bubble_sort_by({|left, right|
	left <=> right

		})