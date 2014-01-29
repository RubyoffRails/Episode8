require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'
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
  my_picks ||= Picks.get_picks
  @featured_pick = my_picks.sample
  erb :about
end

class Picks
  @@picks = []
  def self.get_picks
    YAML.load(File.read("./my_picks.yml"))
  end
end
