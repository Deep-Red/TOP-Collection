require 'rubygems'
require 'rest-client'

fname = "sample.txt"
somefile = File.open(fname, "w")
somefile.puts "Hello File!"
somefile.close

wiki_url = "http://de.wikipedia.org"
wiki_local_filename = "wiki-page.html"
File.open(wiki_local_filename, "w") do |file|
	file.write(RestClient.get(wiki_url))
end