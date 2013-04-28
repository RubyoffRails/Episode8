require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

get '/' do
	about_me = Array["a human being", "female", "a programmer", "fun"]
	random_about_me_choice = rand(about_me.length)
	@about_me_choise = about_me[random_about_me_choice]
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
	about_me = Array["a human being", "female", "a programmer", "fun"]
	random_about_me_choice = rand(about_me.length)
	@about_me_choise = about_me[random_about_me_choice]
	erb :about
end
