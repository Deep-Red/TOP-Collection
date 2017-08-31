puts "Input some words for your alphabetical list."
words = []
keepgoing = 1
while keepgoing != 0 
	newword = gets.chomp 
	words.push newword.to_s
	keepgoing = newword.length
end
puts words.sort