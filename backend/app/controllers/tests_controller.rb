require 'sinatra/base'
require 'json'
require_relative '../models/test'
require_relative '../models/run'

class TestsController < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, 'http://localhost:3000'
  end

  before do
    cross_origin
    content_type :json
  end

  get '/tests' do
    tests = Test.all
    tests.to_json
  end

  get '/tests/run/:id' do 
    run = Run.find_by(id: params[:id])  
    if run 
      run.tests.to_json
    else 
      status 404
      { error: "Run not found" }.to_json
    end
  end

  get '/tests/:id' do
    test = Test.find_by(id: params[:id])
    if test 
      test.to_json(include: :runs)
    else
      status 404
      { error: "Test not found" }.to_json
    end 
  end

end

