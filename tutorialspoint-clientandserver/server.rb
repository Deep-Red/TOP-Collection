require 'socket'
require 'json'

server = TCPServer.new('localhost', 2000)
loop do
	Thread.start(server.accept) do |socket|

#	client = server.accept
	request = client.read_nonblock(256)
	STDERR.puts request

	request_header,request_body = request.split("\r\n\r\n", 2)
	request_header = request_header.split(" ")
	path = request_header[1]
	type = request_header[0]

	if File.exist?(path)
		response_body = File.read(path)
		socket.puts "HTTP/1.1 200 OK\r\nContent-Type:text/html\r\n\r\n"

		if type.upcase == "GET"
			socket.print response_body
		elsif type.upcase == "POST"
			params = JSON.parse(request_body)
			user_data = "<li>name: #{params['viking']['name']}</li><li>e-mail: #{params['viking']['email']}</li>"
			socket.print response_body.gsub("<%= yield %>", user_data)
			socket.print "Made it here!"
		end
	else
	

	socket.print "HTTP/1.1 404 No Good!\r\n\r\n"
	socket.print "404 ERROR"
end
	socket.close
end
end