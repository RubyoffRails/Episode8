require "rubygems"
require "bundler/setup"
require 'yaml'
require 'logger'
require 'active_record'
require 'pg'

require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

namespace :db do
  def create_database config
    options = {:charset => 'utf8', :collation => 'utf8_unicode_ci'}

    create_db = lambda do |config|
      database = config['database']
      puts database
      ActiveRecord::Base.establish_connection config.merge('database' => nil)
      ActiveRecord::Base.connection.create_database config.merge('database' => database), options
      ActiveRecord::Base.establish_connection config
    end

    begin
      create_db.call config
#    rescue Exception => sqlerr
 #     $stderr.puts sqlerr
    end
  end
 
  task :environment do
    DATABASE_ENV = ENV['DATABASE_ENV'] || 'development'
    MIGRATIONS_DIR = ENV['MIGRATIONS_DIR'] || 'db/migrate'
  end

  task :configuration => :environment do
    if ENV['DATABASE_URL'].nil?
      @config = YAML.load_file('config/database.yml')[DATABASE_ENV]
      @config = @config.merge({'schema_search_path'=> 'public'})
    else
      @config = URI.parse(ENV['DATABASE_URL'])
    end
    puts "@config = #{@config.inspect}"
  end

  task :configure_connection => :configuration do
    if @config.respond_to?('path')
      puts @config.path[1..-1]
      ActiveRecord::Base.establish_connection(
        :adapter  => @config.scheme == 'postgres' ? 'postgresql' : @config.scheme,
        :host     => @config.host,
        :port     => @config.port,
        :username => @config.user,
        :password => @config.password,
        :database => @config.path[1..-1],
        :encoding => 'utf8'
      )
    else
      ActiveRecord::Base.establish_connection(@config)
    end
    ActiveRecord::Base.logger = Logger.new STDOUT if @config['logger']
  end

  desc 'Create the database from config/database.yml for the current DATABASE_ENV'
  task :create => :configure_connection do
    create_database @config
  end

  desc 'Drops the database for the current DATABASE_ENV'
  task :drop => :configure_connection do
    ActiveRecord::Base.connection.drop_database @config['database']
  end

  desc 'Migrate the database (options: VERSION=x, VERBOSE=false).'
  task :migrate => :configure_connection do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate MIGRATIONS_DIR, ENV['VERSION'] ? ENV['VERSION'].to_i : nil
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => :configure_connection do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback MIGRATIONS_DIR, step
  end

  desc "Retrieves the current schema version number"
  task :version => :configure_connection do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end
end