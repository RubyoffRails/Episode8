require 'pg'
require 'active_record'

if ENV['DATABASE_URL'].nil?
	require 'yaml'

	connection_details = YAML::load(File.open('config/database.yml'))

	# Setup out connection details
	ActiveRecord::Base.establish_connection(connection_details.merge(
		{'database'=> 'postgres', 'schema_search_path'=> 'public'}))
	# create the 'tv' database 
	ActiveRecord::Base.connection.drop_database (connection_details.fetch('database')) rescue nil
	ActiveRecord::Base.connection.create_database(connection_details.fetch('database')) rescue nil
	# connect to it
	ActiveRecord::Base.establish_connection(connection_details)
	# Migrate all the things
	ActiveRecord::Migrator.migrate("db/migrate/")
else

	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
 
	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)
  ActiveRecord::Base.connection.drop_database (db.path[1..-1]) rescue nil
	ActiveRecord::Base.connection.create_database(db.path[1..-1]) rescue nil
	# connect to it
  ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)
	# Migrate all the things
	ActiveRecord::Migrator.migrate("db/migrate/")
end