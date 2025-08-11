require 'json'

post '/api/run' do
  content_type :json

  # Mock response simulating a test run trigger
  {
    run_id: 1,
    status: "started",
    started_at: Time.now
  }.to_json
end