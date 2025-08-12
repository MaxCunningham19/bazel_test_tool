require 'sinatra/base'
require 'json'
require_relative '../models/run'

class RunsController < Sinatra::Base
  register Sinatra::CrossOrigin
  
  configure do
    enable :cross_origin
    set :allow_origin, 'http://localhost:3000'
  end

  before do
    cross_origin
    content_type :json
  end

  get '/runs/latest' do
    count = (params['count'] || 1).to_i
    runs = Run.latest(count).includes(:links, :tests)

    runs.map do |run|
      {
        run_id: run.run_id,
        status: run.status,
        created_at: run.created_at,
        tests: run.links.map do |link|
          {
            test_id: link.test.test_id,
            name: link.test.name,
            status: link.status,        # <-- status from the join table!
            duration_seconds: link.duration_seconds
            # any other link or test attributes you want here
          }
        end
      }
    end.to_json
  end


  get '/runs/:id' do
    run = Run.find_by(id: params[:id])
    if run
      run.to_json(include: :tests)
    else
      status 404
      { error: "Run not found" }.to_json
    end
  end

  post '/run' do
    data = JSON.parse(request.body.read)
    run = Run.new(data)

    if run.save
      status 201
      run.to_json
    else
      status 422
      { errors: run.errors.full_messages }.to_json
    end
  end
end
