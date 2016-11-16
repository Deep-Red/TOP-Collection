require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

def check_guess(g)
  diff = (g.to_i - SECRET_NUMBER)
  case
  when diff > 5
    "Way too high!"
  when 5 > diff && diff > 0
    "Too high!"
  when -5 < diff && diff < 0
    "Too low!"
  when diff < -5
    "Way too low!"
  when diff == 0
    "You got it right!"
  else
    "Guess not recognized."
  end
end

get '/' do
  g = params['guess']
  message = check_guess(g)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end
