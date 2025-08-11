require 'json'

get '/api/tests/latest' do 
  content_type :json

  count = (params['count'] || 1).to_i

  # Mock response for latest test run
  runs = count.times.map do |i|
    {
      run_id: 42 + i,
      status: "passed",
      flaky_tests: ["test_flaky_42"],
      stable_tests: ["test_stable_42"],
      duration_seconds: 150,
      finished_at: Time.now - 300
    }
  end
  
  runs.to_json
end

get '/api/tests/:id' do
  content_type :json

  # Mock response for a past run by id
  {
    run_id: params['id'].to_i,
    status: "passed",
    flaky_tests: ["test_flaky_1", "test_flaky_2"],
    stable_tests: ["test_stable_1", "test_stable_2"],
    duration_seconds: 120,
    finished_at: Time.now - 3600
  }.to_json
end