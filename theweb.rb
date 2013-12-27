require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'

require_relative 'db/setup'
require_relative 'models/page'
require_relative 'models/book'
require "./db/seed"

enable :sessions

get '/' do
	erb :dashboard
end

post '/number' do
  @number_of_randoms = session[:number_of_randoms] || 0
  @number_of_randoms += 1
  session[:number_of_randoms] = @number_of_randoms
  number_as_string = params.fetch('number').to_i
  @the_number = rand(number_as_string) 
  erb :number
  end


get '/about' do
    @answer_select = []
          @answers = ["She can code in Ruby", "She has a dog named Lulu", "She never quite learned how to ride a bike",
            "She's seen all Die Hard Movies", "She only uses chopsticks to eat her food"]
            @answers.each do |x|
              @answer_select << x
            end
             @reply = @answer_select.sample
             erb :about
end

get  '/adventure' do
      session[:book] = book =  Book.new(Page.starting_point)
      @content = session[:book].current_page.content
      @option_a = session[:book].current_page.options.first.preview
      @option_b = session[:book].current_page.options.last.preview
      erb :adventure
end

post '/option_a' do
  session[:book].input("A")
  @content = session[:book].current_page.content
  if session[:book].complete_game?
    erb :conclusion
  else
    @option_a = session[:book].current_page.options.first.preview
    @option_b = session[:book].current_page.options.last.preview
    erb :adventure
  end

end

  post '/option_b' do
    session[:book].input("B")
    @content = session[:book].current_page.content
    if session[:book].complete_game?
      erb :conclusion
    else
      @option_a = session[:book].current_page.options.first.preview
      @option_b = session[:book].current_page.options.last.preview
      erb :adventure

    end
 end
