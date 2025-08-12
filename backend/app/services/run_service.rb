require 'open3'

class RunService
  def self.trigger_run
    cmd = "bazel test //tests:all --test_output=all"
    started_at = Time.now
    stdout, _, status = Open3.capture3(cmd, chdir: "../project")


    {
      run_id: rand(1000),
      status: status.success ? "passed" : "failed",
      flaky_tests: parse_flaky_tests(stdout),
      stable_tests: parse_stable_tests(stdout),
      started_at: started_at,
      finished_at: Time.now, 
    }
  end

  def self.parse_flaky_tests(output)
    output.lines.select { |l| l.include?("FLAKY") }.map(&:strip)
  end

  def self.parse_stable_tests(output)
    output.lines.select { |l| l.include?("PASSED") && !l.include?("FLAKY") }.map(&:strip)
  end
end