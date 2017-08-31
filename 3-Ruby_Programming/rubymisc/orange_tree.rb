class OrangeTree
	def initialize name
		@height = 0
		@fruit = 0
		@age = 0
		@name = name
		puts "You have planted a seed!"
		puts "Lets call it " + @name + "."
		puts "WAIT a year and let's see what happens."
		inputPrompt
	end

	def height
		return height
	end
	def oneYearPasses
		if (rand(101) - @age) < 0
			puts "Your tree has died."
			exit
		
		elsif @age < 5
			@age += 1
			@height += (8/@age)
			puts "Your tree is " + @height.to_s + " feet tall"
		
		else
			@age += 1
			@height += 1
			@fruit += ((@age/5) + 1)
			puts "A year has passed, your tree is another year older"
			puts "Your tree is " + height + " years old now."
			puts "Your tree has " + @fruit.to_s + " oranges hanging from it's branches."
		end
		puts "What would you like to do now?"
	end
def inputPrompt
	command = gets.chomp.downcase
	if command == "wait"
		@tree.oneYearPasses
	else
		puts "That's very nice and all, but all we can do now is WAIT."
		inputPrompt

	end
end

@tree = OrangeTree.new 'OJay'

end