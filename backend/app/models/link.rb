require 'active_record'

class Link < ActiveRecord::Base
  self.primary_key = "id"

  before_create :set_uuid

  belongs_to :run 
  belongs_to :test

  validates :run_id, presence: true
  validates :test_id, presence: true

  validates :status, inclusion: { in: %w[passed failed flaky]}, allow_nil: false

  private
  def set_uuid
    self.id ||= SecureRandom.uuid
  end
end