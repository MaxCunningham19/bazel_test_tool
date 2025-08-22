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
        started_at: run.started_at,
        completed_at: run.completed_at,
        duration_seconds: run.duration_seconds,
        tests: run.links.map do |link|
          {
            test_id: link.test.id,
            name: link.test.name,
            path: link.test.path,
            status: link.status,
            duration_seconds: link.test_duration
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
    started_at: result[:started_at],
    completed_at: result[:completed_at],
    duration_seconds: result[:completed_at] - result[:started_at]
  )
  
  result[:tests].each do |test_info|
    test = Test.find_or_initialize_by(name: test_info[:name])
    test.status = test_info[:test_status]
    test.path ||= test_info[:test_path]
    test.save!

    Link.create!(
      run: run,
      test: test,
      status: test_info[:test_status],
      test_duration: test_info[:test_duration]
    )
  end

  content_type :json
  run.to_json(include: { tests: { only: [:id, :name, :status] } })
end


end
