require 'sinatra/base'
require 'json'
require_relative '../models/run'
require_relative '../services/run_service'

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
        id: run.id,
        status: run.status,
        created_at: run.created_at,
        tests: run.links.map do |link|
          {
            test_id: link.test.id,
            name: link.test.name,
            status: link.status,
            duration_seconds: link.completed_at
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
  attempts = data['test_attempts'] || 1
  result = RunService.trigger_run(attempts)
  puts result
  run = Run.create!(
    status: result[:status] == "error" ? "build_error" : result[:status],
    duration_seconds: (result[:finished_at] - result[:started_at]).to_i
  )
  
  result[:tests].each do |test_info|
    test = Test.find_or_create_by!(name: test_info[:name]) do |t|
      t.status = test_info[:test_status]
    end
    test.update!(status: test_info[:test_status])
  
    Link.create!(
      run: run,
      test: test,
      status: test_info[:test_status]
    )
  end

  content_type :json
  run.to_json(include: { tests: { only: [:id, :name, :status] } })
end


end
