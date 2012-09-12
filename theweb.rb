require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'geocoder'
enable :sessions

get "/" do
  @about_mes = [
    { title: "I like Gems", content: "They're shiny - how could you not like 'em?" },
    { title: "Pocket Hankie Collection", content: "I own a nationally-ranked pocket hankie collection. I have won prizes at the Snotragorama '06, '09, and '10." },
    { title: "Extremely Short", content: "I am only 4'3\"." },
    { title: "Wiggly Ears", content: "I can wiggle my ears (without touching them, of course)." },
    { title: "Acrobatic", content: "I can walk on my hands." },
    { title: "Good Liar", content: "All of these \"facts\" about me are complete made up!" }
  ]
  erb :about
end

get '/about' do
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
