# frozen_string_literal: true

class Heartbeat < ApplicationRecord
  belongs_to :switch
  belongs_to :heartbeat_destination

  validates :switch, presence: true
  validates :heartbeat_destination, presence: true
end
