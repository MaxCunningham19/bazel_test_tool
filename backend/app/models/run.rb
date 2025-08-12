require 'active_record'
require 'securerandom'

class Run < ActiveRecord::Base
  self.primary_key = "id"

  before_create :set_uuid

  has_many :links
  has_many :tests, through: :links  

  validates :status, presence: true, inclusion: { in: %w[started passed failed build_error]}, allow_nil: false
  validates :duration_seconds, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true


  scope :passed, -> { where(status: "passed") }
  scope :failed, -> { where(status: "failed") }
  scope :build_error, -> { where(status: "build_error") }
  scope :started, -> { where(status: "started") }
  scope :latest, ->(lim) { order(created_at: :desc).limit(lim) }

  private
  def set_uuid
    self.id ||= SecureRandom.uuid
  end
end