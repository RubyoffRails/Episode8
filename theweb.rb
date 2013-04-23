require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

get '/' do
	#erb :dashboard
	@about_text = []
	@about_text << "I've been learning Ruby for about five months."
	@about_text << "I live in Atlanta, Georgia."
	@about_text << "I like reading, knitting, and gardening."
	@about_text << "I went to Clemson University. Go Tigers!!"
	session[:random_text] = @about_text
	@random_text = session[:random_text].sample
	erb :about
end

get '/about' do
	@random_text = session[:random_text].sample
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
