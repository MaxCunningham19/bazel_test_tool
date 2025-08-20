require 'open3'

class RunService
  def self.trigger_run(n)
    cmd = "bazel test //... --cache_test_results=no --flaky_test_attempts=#{self.sanitize_input(n)}"
    started_at = Time.now
    stdout, stderr, status = Open3.capture3(cmd, chdir: "../project")

    tests = self.parse_tests(stdout)
    run_status = status.success? ? "passed" : tests.any? { |test| test[:test_status] == "FAILED" } ? "failed" : "build_error"
    {
      status: run_status, 
      tests: tests, 
      started_at: started_at,
      finished_at: Time.now, 
      error_message: stderr.strip,
    }
  end

  def self.parse_tests(output)
    test_lines =  output.lines.select { |l| l =~ /\b(PASSED|FAILED|FLAKY)\b/}
    test_lines.map{ |l| self.parse_test(l.split(" "))}
  end

  def self.parse_test(test_words) 
    {
      name: test_words[0],
      test_status: self.parse_status(test_words[1]),
      test_duration: test_words[test_words.length - 1]
    }
  end

  def self.sanitize_input(value)
    if value.is_a?(Numeric) && value > 0 
      value
    else
      1
    end
  end

  private 
  def self.parse_status(status)
    if status == "PASSED" || status == "FAILED"
      status
    else 
      status[0..-2]
    end.downcase
  end
end