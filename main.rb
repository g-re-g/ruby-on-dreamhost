# We specify the exact versions of the gems we want to work with here
# just in case you are developing locally and a different version gets
# loaded by default. Then you might use some features from a different
# version of the gem that may not work on Dreamhost.
gem 'sqlite3', '1.4.4'
gem 'sinatra', '2.2.4'
gem 'sinatra-contrib', '2.2.4'

require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/json'
require "sqlite3"

# Create / Open the sqlite3 database
db = SQLite3::Database.new "test.db"

# Create a table if it doesn't exist
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS test (
    id TEXT PRIMARY KEY
  );
SQL

get '/' do
  # create some rows
  db.execute <<~SQL
    INSERT INTO test (body) VALUES("test 1");
  SQL

  # fetch some rows
  rows = db.execute("SELECT id from test;")

  # display a count
  erb :index, locals: {rows: rows}
end
