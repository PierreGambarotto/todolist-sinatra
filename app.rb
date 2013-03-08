# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/respond_with'
require 'sinatra/json'
require_relative './authentication'
require_relative './db/database'
require_relative './lib/todo'

use Authentication
helpers AuthenticationHelpers
set :environment, ENV['RACK_ENV'] || :development
before '/resource*' do
  logger.info("ressource protégée")
  authenticate!
end

get '/' do
  redirect '/todos'
end

get '/todos' do
  @todos = Todo.all
  erb :index
end

post '/todos' do
  Todo.create(params[:todo])
  redirect '/todos'
end
delete '/todos/:id' do
  logger.info(params.inspect)
  todo = Todo.find(params[:id])
  todo.destroy if todo
  redirect '/todos'
end


