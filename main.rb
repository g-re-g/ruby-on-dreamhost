# Required to make vendored gems work correctly
require 'rubygems'
require 'bundler/setup'

# Require more gems here
require 'sinatra'
require 'sinatra/contrib'
require "sqlite3"

# Create / Open the sqlite3 database
db = SQLite3::Database.new "test.db"

# Create a table if it doesn't exist
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS test (
    id TEXT PRIMARY KEY,
    body TEXT
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