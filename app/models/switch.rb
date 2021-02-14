# frozen_string_literal: true

class Switch < ApplicationRecord
  belongs_to :user

  has_many :heartbeat_destinations, dependent: :destroy
  has_many :heartbeats, through: :heartbeat_destinations

  has_many :switch_destinations, dependent: :destroy

  encrypts :name, :content

  enum heartbeat_interval: { daily: 0, weekly: 1, monthly: 2 }

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
