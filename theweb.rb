require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

helpers do
	def fun_fact
		facts = [
			'I love Chinese Food.',
			'Quentin Tarantino is my favorite movie director.',
			'I keep wanting to learn Erlang, but haven\'t found the time.',
			'My favorite dessert of all time is blueberry crumble.'
		]

		facts[rand(facts.size)]
	end
end

get '/' do
	erb :dashboard
end
