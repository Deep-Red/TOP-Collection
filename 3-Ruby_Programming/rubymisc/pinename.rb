puts "What is your first name?"
fn = gets.chomp
puts "What is your middle name?"
mn = gets.chomp
puts "What is your last name?"
ln = gets.chomp

puts "Greetings " + fn + " " + mn + " " + ln + "!"
puts "What is your favorite number, " + fn + "?"
favn = gets.chomp.to_i
favn2 = favn + 1
puts "You know, " + favn2.to_s + " would make for a bigger and better favorite..."
puts "Or, you could use the number of letters in your name:" + (fn.length + mn.length + ln.length).to_s
