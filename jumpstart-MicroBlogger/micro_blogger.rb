require 'jumpstart_auth'
require 'bitly'

Bitly.use_api_version_3

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing MicroBlogger"
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		if message.length < 141
			@client.update(message)
		else
			puts "Your message is too long for a tweet."
		end
	end

	def run
		puts "Welcome to the JSL twitter client."
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
			when 'q' then puts "Goodbye!"
			when 't' then tweet(parts[1..-1].join(" "))
			when 'dm' then dm(parts[1], parts[2..-1].join(" "))
			when 'spam' then spam_my_followers(parts[1..-1].join(" "))
			when 'elt' then everyones_last_tweet
			when 's' then shorten(parts[-1])
			when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
			else 
				puts "Sorry, I don't know how to #{command}"
			end
		end
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct message: "
		puts message
		message = "d @#{target} #{message}"
		screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
		if screen_names.include?(target) 
		then tweet(message)
		else puts "#{target} is not one of your followers."
		end
	end

	def followers_list
		screen_names = []
		@client.followers.each { |follower| screen_names << @client.user(follower).screen_name }
		return screen_names
	end

	def spam_my_followers(message)
		followers = followers_list
		followers.each { |follower| dm(follower, message) }
	end

	def everyones_last_tweet
		friends = []
		@client.followers.each { |follower| friends << @client.user(follower) }
		friends = friends.sort
		friends.each do |friend|
			timestamp = friend.status.created_at
			puts friend.screen_name
			puts friend.status.text
			puts timestamp.strftime( "%A, %b %d, %y" )
			puts ""
		end
	end

	def shorten(original_url)
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		puts "Shortening this URL: #{original_url}"
		return bitly.shorten(original_url).short_url
	end
end

tweet = "".ljust(140, "abcd")
blogger = MicroBlogger.new
blogger.run