# frozen_string_literal: true

class Switch < ApplicationRecord
  belongs_to :user

  has_many :heartbeats, dependent: :destroy

  has_encrypted :name, :content, :heartbeat_address, :switch_address

  enum heartbeat_interval: { daily: 0, weekly: 1, monthly: 2 }

  validates :name, presence: true
  validates :content, presence: true
  validates :heartbeat_address, presence: true
  validates :switch_address, presence: true
  validates :missed_heartbeats, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :max_missed_heartbeats, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :heartbeat_interval, inclusion: { in: Switch.heartbeat_intervals }

  validate :validate_heartbeat_address
  validate :validate_switch_address

  def validate_heartbeat_address
    return if heartbeat_address.blank?
    return if heartbeat_address.match?(EMAIL_REGEX)

    errors.add(:heartbeat_address, 'must be an email address')
  end

  def validate_switch_address
    return if switch_address.blank?
    return if switch_address.match?(EMAIL_REGEX)

    errors.add(:switch_address, 'must be an email address')
  end

  def alive?
    missed_heartbeats < max_missed_heartbeats
  end

  def dead?
    !alive?
  end
end
