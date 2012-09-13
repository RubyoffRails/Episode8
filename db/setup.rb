require 'pg'
require 'active_record'
require 'yaml'
require 'uri'

if ENV['DATABASE_URL'].nil?

  connection_details = YAML::load(File.open('config/database.yml'))
  # Setup our connection details
  ActiveRecord::Base.establish_connection(connection_details.merge({'database'=> 'postgres', 'schema_search_path'=> 'public'}))
  # create the 'tv' database 
  ActiveRecord::Base.connection.drop_database (connection_details.fetch('database')) rescue nil
  ActiveRecord::Base.connection.create_database(connection_details.fetch('database')) rescue nil
  # connect to it
  ActiveRecord::Base.establish_connection(connection_details)
  # Migrate all the things
  ActiveRecord::Migrator.migrate("db/migrate/")

else

  db = URI.parse(ENV['DATABASE_URL'])
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :port     => db.port,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )

end