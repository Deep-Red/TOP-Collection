def beer(n)
	if n == 0 
		puts "no more bottles of beer on the wall"
		return
	else
		puts "#{n} bottles of beer on the wall"
		n -= 1
		puts "#{n} bottles of beer on the wall"
		beer(n)
	end
end

n = 99
beer(n)