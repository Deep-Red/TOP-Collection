require 'rest-client'
#print "url:  "
#url = gets.chomp
#puts RestClient.get(url)
url = "http://localhost:3000/users"
RestClient.post(url,"")
