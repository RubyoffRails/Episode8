require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

require_relative 'db/setup'
require_relative 'models/page'
require_relative 'models/book'
require "./db/seed"
enable :sessions

get '/number' do
  erb :number
end

post '/number' do
	@number_of_randoms = session[:number_of_randoms] || 0
	@number_of_randoms += 1
	session[:number_of_randoms] = @number_of_randoms
	number_as_string = params.fetch('number').to_i
	@the_number = rand(number_as_string)
	erb :number
end

get '/' do
  my_picks ||= Picks.get_picks
  @featured_pick = my_picks.sample
  erb :about
end

get '/adventure' do
  @page = Page.starting_point
  @book = Book.new(@page)
  session[:book] = @book
  erb :adventure
end

get '/adventure/my_game' do
  erb :"adventure/my_game"
end

post '/adventure/my_game' do
  selected_option = params.fetch('selected_option')
  session[:book].input(selected_option)
  if session[:book].complete_game?
    erb :"adventure/complete"
  else
    redirect :"adventure/my_game"
  end
end

get '/adventure/complete' do
  erb :"adventure/complete"
end

class Picks
  @@picks = []
  def self.get_picks
    YAML.load(File.read("./my_picks.yml"))
  end
end











