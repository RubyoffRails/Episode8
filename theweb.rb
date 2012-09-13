require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'geocoder'

require_relative 'db/setup'
require_relative 'models/page'
require_relative 'models/book'
require_relative 'db/seed'

enable :sessions

before do
  @number_of_randoms = session[:number_of_randoms] || 0
end

get "/" do
  @about_mes = [
    { title: "I like Gems", content: "They're shiny - how could you not like 'em?" },
    { title: "Pocket Hankie Collection", content: "I own a nationally-ranked pocket hankie collection. I have won prizes at the Snotragorama '06, '09, and '10." },
    { title: "Extremely Short", content: "I am only 4'3\"." },
    { title: "Wiggly Ears", content: "I can wiggle my ears (without touching them, of course)." },
    { title: "Acrobatic", content: "I can walk on my hands." },
    { title: "Good Liar", content: "All of these \"facts\" about me are completely made up!" }
  ]
  erb :about
end

get '/random' do
  erb :dashboard
end

post '/number' do
  @number_of_randoms += 1
  session[:number_of_randoms] = @number_of_randoms
  number_as_int = params.fetch('number').to_i
  @the_number = rand(number_as_int)
  erb :number
end

get '/adventure' do
  @page = session[:page] || Page.starting_point
  session[:page] = @page
  @book = Book.new(@page)
  if @book.complete_game?
    erb :complete
  else
    erb :page
  end
end

post '/adventure' do
  @book = Book.new(session[:page])
  session[:page] = @book.input(params[:choice])
  puts params[:choice]
  redirect '/adventure'
end

post '/reset' do
  session[:page] = nil
  redirect '/adventure'
end
