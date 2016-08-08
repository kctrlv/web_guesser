require 'sinatra'
require 'sinatra/reloader'

@@guesses = 5
@@SECRET_NUM = rand(100)

get '/' do
  guess = params['guess']
  check_guess(guess.to_i) if guess
  data = {:message => @msg, :bg_color => @color, :num_guesses => @@guesses}
  erb :index, :locals => data
end

def check_guess(guess)
  return nil unless guess
  @@guesses -= 1
  if guess == @@SECRET_NUM
    @color = 'springgreen'
    @msg = "You got it right! The secret number is #{@@SECRET_NUM}. Please play again."
    return reset
  elsif (guess - @@SECRET_NUM).abs <= 5
    @color = 'lightpink'
    @msg = guess > @@SECRET_NUM ? "Too high!" : "Too low"
  else
    @color = 'red'
    @msg = guess > @@SECRET_NUM ? "Way too high!" : "Way too low!"
  end
  if @@guesses == 0
    @msg = "You lost. The number has been reset. Care to try again?"
    reset
  end

  def reset
    @@guesses = 5
    @@SECRET_NUM = rand(100)
  end
end
