# frozen_string_literal: true

class SwitchDestination < ApplicationRecord
  belongs_to :switch

  enum switch_destination_type: { email: 0 }

  encrypts :switch_destination_address

  validates :switch, presence: true
  validates :switch_destination_type, inclusion: { in: SwitchDestination.switch_destination_types }
  validates :switch_destination_address, presence: true
end
