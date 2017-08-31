puts "Input some words for me to alphabetize."
wordlist = []
keepgoing = 1

while keepgoing != 0
	newword = gets.chomp
	wordlist.push newword.to_s
	keepgoing = newword.length
end

wordlist.pop
keepgoing = 1

while keepgoing == 1
wordlist2 = wordlist
wordlist[0...-1].each_with_index do |el, i|
	if el > wordlist[i+1]
		wordlist[i], wordlist[i+1] = wordlist[i+1], wordlist[i]
		keepgoing = 1
		wordlist2 = []
	elsif wordlist != wordlist2
		keepgoing = 1
		wordlist2 = []
	else 
		keepgoing = 0
end
end
end
puts wordlist