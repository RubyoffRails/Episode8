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

get '/random' do
	erb :random
end

get '/adventure' do
	session[:book] = book = Book.new(Page.starting_point)
	@content = session[:book].current_page.content
	@option_1 = session[:book].current_page.options.first.preview
	@option_2 = session[:book].current_page.options.last.preview
	erb :adventure
end

post '/option_1' do
	session[:book].input("A")
	@content = session[:book].current_page.content
	if session[:book].complete_game?
		erb :conclusion
	else
		@option_1 = session[:book].current_page.options.first.preview
		@option_2 = session[:book].current_page.options.last.preview
		erb :adventure	
	end
end

post '/option_2' do
	session[:book].input("B")
	@content = session[:book].current_page.content
	if session[:book].complete_game? 
		erb :conclusion
	else
		@option_1 = session[:book].current_page.options.first.preview
		@option_2 = session[:book].current_page.options.last.preview
		erb :adventure
	end
end

post '/number' do
	@number_of_randoms = session[:number_of_randoms] || 0
	@number_of_randoms += 1
	session[:number_of_randoms] = @number_of_randoms
	number_as_string = params.fetch('number').to_i
	@the_number = rand(number_as_string)
	erb :number
end

