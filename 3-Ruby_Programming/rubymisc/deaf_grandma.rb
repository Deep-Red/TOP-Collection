
leave = 0
kidsays = " "
puts "Hi, Young'un!"

while leave < 3 

kidsays = gets.chomp

if leave == 3
	puts "COME BACK SOON!"
elsif kidsays == "BYE"
	leave += 1
	puts "WHAT'S THAT YOU SAID?"
elsif kidsays == kidsays.upcase
	puts "NO, NOT SINCE " + (1930 + rand(21)).to_s + "!"
	leave = 0
else
	puts "HUH? SPEAK UP, SONNY!"
	leave = 0
end
end