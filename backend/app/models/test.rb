require 'active_record'
require 'securerandom'

class Test < ActiveRecord::Base
  has_many :links 
  has_many :runs, through: :links

  validates :name, presence: true, uniqueness: true
  validates :status, inclusion: { in: %w[passed failed flaky]}, allow_nil: false

  scope :flaky, -> {where(status: "flaky")}
  scope :passing, -> {where(status: "passed")}
  scope :failing, -> {where(status: "failed")}

  def passed?
    status == "passed"
  end

  def failed?
    status == "failed"
  end

  def flaky?
    status == "flaky"
  end
end