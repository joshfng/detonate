# frozen_string_literal: true

class Release < ApplicationRecord
  belongs_to :switch

  enum release_type: { email: 0 }

  encrypts :release_address
end
