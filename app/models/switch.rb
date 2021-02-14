# frozen_string_literal: true

class Switch < ApplicationRecord
  belongs_to :user

  has_many :heartbeat_destinations, dependent: :destroy
  has_many :heartbeats, dependent: :destroy

  has_many :switch_destinations, dependent: :destroy

  encrypts :name, :content

  enum heartbeat_interval: { daily: 0, weekly: 1, monthly: 2 }

  validates :user, presence: true
  validates :max_missed_heartbeats, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :heartbeat_interval, inclusion: { in: Switch.heartbeat_intervals }

  def missed_heartbeats
    heartbeats.where(heartbeat_confirmed: false).count
  end

  def alive?
    missed_heartbeats < max_missed_heartbeats
  end

  def dead?
    !alive?
  end
end
