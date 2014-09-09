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

post '/about' do
	ryan_facts = ['Chuck Norris wears a Ryan Moser jersey',
											 'Ryan is likely to have a squid on his head',
											 'Ryan likes to do math for fun and profit', 
											 'The creature Ryan most resembles is a box turtle']
	@ryan_fact = ryan_facts[rand( ryan_facts.length )]
	erb :about
end