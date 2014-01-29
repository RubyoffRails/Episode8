require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

abouts = {"First Name" => "Noah", "Last Name" => "Patterson", "Cat Two" => "Minna", "Cat One" => "Navi", "City" => "Washington, DC", "First Email" => "noah@noah-patterson.com", "Second Email" => "albinosquirrelclimb@gmail.com", "Home Town" => "Asheville, NC", "Favorite Food" => "cheese danish", "Twitter" => "@albinosquirrel"}
keys = abouts.keys

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

get '/about' do
    @a = keys.sample
    an_about = abouts.select { |k,v| k == @a }
    @keys = an_about
    an_about.each do |k,v|
      @title = k
      @info = v
    end
    erb :about, :layout  => false
end
