require 'sinatra'
require 'sinatra/activerecord'
require './environments'

require_relative 'models/page'
require_relative 'models/book'
require_relative 'db/seed'


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
	number_as_string = params.fetch('number').to_i || 100
	@the_number = rand(number_as_string)
	erb :number
end

get '/number' do
  erb :dashboard
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

post '/adventure' do
    if settings.development?
      connection_details = YAML::load(File.open('config/database.yml'))
      ActiveRecord::Base.connection_pool.with_connection do
        ActiveRecord::Base.establish_connection(connection_details)
      end
    end
    book = Book.new(Page.find(params.fetch('id')))
    book.input(params.fetch('selection'))
 
    @current_page = book.current_page.id

    if book.complete_game?
      @content = book.current_page.content 
      @end = true
    else
      @end = false
      @content = book.current_page.content 
      @choiceOne = Page.find(book.current_page.option_ids.first).preview
      @choiceTwo = Page.find(book.current_page.option_ids.last).preview
    end
    erb :adventure, :layout  => false
end

get '/adventure' do
  if settings.development?
    connection_details = YAML::load(File.open('config/database.yml'))
      ActiveRecord::Base.connection_pool.with_connection do
        ActiveRecord::Base.establish_connection(connection_details)
      end
  end
  book = Book.new(Page.where(starting_point: true).first)
  @content = book.current_page.content
  @current_page = book.current_page.id
  @choiceOne = Page.find(book.current_page.option_ids.first).preview
  @choiceTwo = Page.find(book.current_page.option_ids.last).preview

  erb :adventure


end
