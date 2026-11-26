require 'debug'
require "awesome_print"

class App < Sinatra::Base
    register Sinatra::Reloader

    def db
      return @db if @db

      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
    end

    def todo id
        db.execute('SELECT * FROM todos WHERE id=?', id).first
    end

    def todos
        db.execute('SELECT * FROM todos')
    end

    get '/' do
        redirect(:'/todos')
    end

    get '/todos' do
        @todos = todos
        erb(:'todos/index')
    end

    get '/todos/new' do
        erb(:'todos/new')
    end

    get '/todos/:id' do |id|
        @todo = todo id
        erb(:'todos/show')        
    end
end
