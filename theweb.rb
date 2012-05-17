require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
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
