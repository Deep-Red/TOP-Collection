require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@attempts_remaining = 5
@bg_color = "white"
def check_guess(g)
  diff = (g.to_i - @@secret_number)
  case
  when diff > 5
    @bg_color = "#FF0000"
    "Way too high!"
  when 5 >= diff && diff > 0
    @bg_color = "#FFAAAA"
    "Too high!"
  when -5 <= diff && diff < 0
    @bg_color = "#FFAAAA"
    "Too low!"
  when diff < -5
    @bg_color = "#FF0000"
    "Way too low!"
  when diff == 0
    @bg_color = "#00FF00"
    "You got it right!"
  else
    @bg_color = "#333333"
    "Guess not recognized."
  end
end

def game_status
  if @message == "You got it right!"
    @@secret_number = rand(100)
    @message = "You win! A new number has been generated!"
  elsif @@attempts_remaining <= 0
    @@secret_number = rand(100)
    @@attempts_remaining = 5
    @message = "You lost! Try to guess the new number!"
  else
    @@attempts_remaining -= 1
  end
end

get '/' do
  g = params['guess']
  cheat_mode = params['cheat']
  @message = check_guess(g)
  game_status
  erb :index, :locals => {:number => @@secret_number, :message => @message, :bgc => @bg_color, :cheat_mode => cheat_mode}
end
