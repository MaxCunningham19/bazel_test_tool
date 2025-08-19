# spec/run_service_spec.rb
require 'rspec'
require_relative '../../app/services/run_service'

RSpec.describe RunService do
  describe ".sanitize_input" do
    it "returns the number if it is positive" do
      expect(RunService.sanitize_input(5)).to eq(5)
    end

    it "returns 1 if the number is zero or negative" do
      expect(RunService.sanitize_input(0)).to eq(1)
      expect(RunService.sanitize_input(-10)).to eq(1)
    end

    it "returns 1 if the input is not a number" do
      expect(RunService.sanitize_input("abc")).to eq(1)
    end
  end

  describe ".parse_test" do 
    it "words for PASSED test" do
      test = {
        name: "//quiz:quiz_test",
        test_status: "PASSED",
        test_duration: "0.0s", 
      }
      test_words = "//quiz:quiz_test                                                         PASSED in 0.0s".split
     expect(RunService.parse_test(test_words)).to eq(test)
    end

    it "works for FLAKY test" do 
      test = {
        name: "//questions:questions_test",
        test_status: "FLAKY",
        test_duration: "0.1s", 
      }
      test_words = "//questions:questions_test                                                FLAKY, failed in 3 out of 4 in 0.1s".split
     expect(RunService.parse_test(test_words)).to eq(test)
 
    end
  end

  describe ".parse_tests" do
    it "works for two tests" do 
      tests = [
        {
          name: "//quiz:quiz_test",
          test_status: "PASSED",
          test_duration: "0.0s", 
        },
        {
          name: "//questions:questions_test",
          test_status: "FLAKY",
          test_duration: "0.1s", 
        },
      ]
      input = <<~TEXT
          //quiz:quiz_test                                                         PASSED in 0.0s
          //questions:questions_test                                                FLAKY, failed in 3 out of 4 in 0.1s
        TEXT

      expect(RunService.parse_tests(input)).to eq(tests)
    end

    it "excludes irrelevant lines" do 
      tests = [
        {
          name: "//quiz:quiz_test",
          test_status: "PASSED",
          test_duration: "0.0s", 
        },
        {
          name: "//questions:questions_test",
          test_status: "FLAKY",
          test_duration: "0.1s", 
        },
      ]
      input = <<~TEXT
          god I hate mondays
          //quiz:quiz_test                                                         PASSED in 0.0s
          //questions:questions_test                                                FLAKY, failed in 3 out of 4 in 0.1s
          I found two fish.
        TEXT

      expect(RunService.parse_tests(input)).to eq(tests)
    end
  end

end
