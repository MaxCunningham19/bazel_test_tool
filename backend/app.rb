require 'sinatra'
require 'json'
# require_relative 'bazel_runner'
# require_relative 'run_store'

set :bind, '0.0.0.0'
set :port, 4567

# store = RunStore.new

post '/api/run-tests' do
# TODO(maxc): add in the ability to run tests
end

get '/api/run-tests/:id' do
# TODO(maxc): add in the ability to get past runs
end

get 'api/tests/latest' do 
# TODO(maxc): add in the ability to get the most recent test
end