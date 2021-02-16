# frozen_string_literal: true

class SwitchDestination < ApplicationRecord
  belongs_to :switch

  enum switch_destination_type: { email: 0 }

  encrypts :switch_destination_address

  validates :switch, presence: true
  validates :switch_destination_type, inclusion: { in: SwitchDestination.switch_destination_types }
  validates :switch_destination_address, presence: true

  validate :validate_switch_destination_address

  def validate_switch_destination_address
    case switch_destination_type
    when 'email'
      unless switch_destination_address.present? && switch_destination_address.match?(EMAIL_REGEX)
        errors.add(:switch_destination_address, 'must be an email address')
      end
    end
  end
end
