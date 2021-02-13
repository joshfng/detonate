# frozen_string_literal: true

class HeartbeatDestination < ApplicationRecord
  belongs_to :switch

  has_many :heartbeats, dependent: :destroy

  enum heartbeat_type: { email: 0 }

  encrypts :heartbeat_address

  # validate switch_id is owned by user
end
