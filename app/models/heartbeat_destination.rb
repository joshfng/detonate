# frozen_string_literal: true

class HeartbeatDestination < ApplicationRecord
  belongs_to :switch

  has_many :heartbeats, dependent: :destroy

  enum heartbeat_destination_type: { email: 0 }

  encrypts :heartbeat_destination_address

  validates :switch, presence: true
  validates :heartbeat_destination_type, inclusion: { in: HeartbeatDestination.heartbeat_destination_types }
  validates :heartbeat_destination_address, presence: true

  validate :validate_heartbeat_destination_address

  def validate_heartbeat_destination_address
    case heartbeat_destination_type
    when 'email'
      unless heartbeat_destination_address.present? && heartbeat_destination_address.match?(EMAIL_REGEX)
        errors.add(:heartbeat_destination_address, 'must be an email address')
      end
    end
  end
end
