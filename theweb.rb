require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

get '/' do
  @title = "Patrick Irwin"
  likes = ["Turtles", "Cake", "Puppies", "Ruby", "Archer (The Cartoon)", "PC Games", "Stuff", "Apples", "Programming"]
  @random_likes = likes[rand(likes.length)]
	erb :dashboard
end

