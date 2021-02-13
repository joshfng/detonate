# frozen_string_literal: true

class Switch < ApplicationRecord
  belongs_to :user

  has_many :hearbeat_destinations, dependent: :destroy
  has_many :releases, dependent: :destroy

  has_many :heartbeats, through: :hearbeat_destinations

  encrypts :name, :content

  enum heartbeat_interval: { daily: 0, weekly: 1, monthly: 2 }
end
