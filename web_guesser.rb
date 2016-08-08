require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)


get '/' do
  guess = params['guess']
  message = check_guess(guess) if guess
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
  mark = guess.to_i - SECRET_NUMBER
  if mark > 0
    mark.abs > 5 ? 'Way too high!' : 'Too high!'
  elsif mark < 0
    mark.abs > 5 ? 'Way too low!' : 'Too low!'
  else
    "You got it right! The secret number is #{SECRET_NUMBER}"

  end
end
