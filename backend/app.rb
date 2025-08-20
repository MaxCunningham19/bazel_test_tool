require 'sinatra'
require 'sinatra/cross_origin'  # <-- add this
require 'active_record'
require_relative 'config/database'
require_relative './app/controllers/runs_controller'
require_relative './app/controllers/tests_controller'
require_relative './app/models/run'
require_relative './app/models/test'
require_relative './app/models/link'


class App < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, 'http://localhost:3000'
    set :allow_methods, [:get, :post, :options, :put, :delete]
    set :allow_headers, ['*', 'Content-Type', 'Accept', 'Authorization', 'Token']
    set :expose_headers, ['Content-Type']
  end

  before do
    cross_origin
  end

  options '*' do
    response.headers['Allow'] = 'HEAD,GET,POST,PUT,DELETE,OPTIONS'
    response.headers['Access-Control-Allow-Origin'] = settings.allow_origin
    response.headers['Access-Control-Allow-Methods'] = settings.allow_methods.map(&:to_s).join(',')
    response.headers['Access-Control-Allow-Headers'] = settings.allow_headers.join(',')
    200
  end

  use RunsController
  use TestsController
end

if $PROGRAM_NAME == __FILE__
  App.run!
end