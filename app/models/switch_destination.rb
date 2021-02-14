# frozen_string_literal: true

class SwitchDestination < ApplicationRecord
  belongs_to :switch

  enum switch_destination_type: { email: 0 }

  encrypts :switch_destination_address

  # validate switch_id is owned by user
end
