require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
enable :sessions

# get '/' do
#   erb :dashboard
# end

post '/number' do
	@number_of_randoms = session[:number_of_randoms] || 0
	@number_of_randoms += 1
	session[:number_of_randoms] = @number_of_randoms
	number_as_string = params.fetch('number').to_i
	@the_number = rand(number_as_string)
	erb :number
end

get '/' do 
  about_me = [{url: 'http://www.cpap.com/aboutUsPerson.php?AboutUsID=6', anchor: 'CPAP.com About Us Page'}, 
               {url: 'http://www.linkedin.com/profile/view?id=6892236', anchor: 'Linked In Profile'},
               {url: 'https://github.com/johnnygoodman', anchor: 'Github Profile'}]                 
  selected = about_me.shuffle.take(1).first
  @about_me_url = selected.fetch(:url)
  @about_me_anchor = selected.fetch(:anchor)   
  erb :about
end