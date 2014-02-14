require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

post '/number' do
	@number_of_randoms = session[:number_of_randoms] || 0
	@number_of_randoms += 1
	session[:number_of_randoms] = @number_of_randoms
	number_as_string = params.fetch('number').to_i
	@the_number = rand(number_as_string)
	erb :number
end

get '/' do
  list = [ 'I\'m a new fan of Ice Hockey.',
           'My favourite team is the Chicago Blackhawks.',
           'I like Purple.',
           'The next language I\'m learning is Python.'
         ]
  @factoid = list.shuffle.sample
  erb :about
end
