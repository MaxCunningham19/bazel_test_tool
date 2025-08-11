require 'sinatra'
require 'sinatra/cross_origin'
require 'json'
require_relative 'routes/runs'
require_relative 'routes/tests'

configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

options '*' do
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Accept, Authorization, Token'
  200
end

set :bind, '0.0.0.0'
set :port, 4567
