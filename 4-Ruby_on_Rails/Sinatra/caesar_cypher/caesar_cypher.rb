require 'sinatra'
require 'sinatra/reloader' if development?

def caesar_cypher(text, sd)
	@numerical = text.bytes
  sd = sd.to_i
	@numerical.map! do |num|
		if num > 96 && num < 123
			num = (((num + sd - 97) % 26) + 97);
		elsif num > 64 && num < 91
			num = (((num + sd - 65) % 26) + 65);
		else num = num
		end
	end
	return @numerical.pack('C*')
end

get '/' do
  original = params['original']
  key = params['key']
  encrypted_message = caesar_cypher(original, key) if original != nil
  erb :index, :locals => {:encrypted_message => encrypted_message}
end
