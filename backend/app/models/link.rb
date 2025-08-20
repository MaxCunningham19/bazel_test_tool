require 'active_record'
require 'securerandom'

class Link < ActiveRecord::Base
  belongs_to :run 
  belongs_to :test

  validates :run_id, presence: true
  validates :test_id, presence: true

  validates :status, inclusion: { in: %w[passed failed flaky]}, allow_nil: false
end