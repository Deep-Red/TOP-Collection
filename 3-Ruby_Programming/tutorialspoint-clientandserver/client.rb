require 'socket'

hostname = 'localhost'
port = 2000
path = "index.html"

request = "GET #{path} HTTP/1.0\r\n\r\n"
s = TCPSocket.open(hostname, port)

s.print(request)
response = s.read

headers,body = response.split("\r\n\r\n", 2)

print body
#while line = s.gets
#	puts line.chop
#end

#s.close