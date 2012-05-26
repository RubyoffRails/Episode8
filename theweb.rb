require 'rubygems'
require 'bundler/setup'
require 'sinatra'

enable :sessions

get '/' do
	@a = ["Is new to this","Just had a baby","When does summer start?"].sample
	erb :about
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
	erb :about
end

get '/random' do
	erb :dashboard
end
