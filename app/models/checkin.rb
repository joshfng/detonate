# frozen_string_literal: true

class Checkin < ApplicationRecord
  belongs_to :switch

  has_many :user_checkins, dependent: :destroy

  enum checkin_type: { email: 0 }

  encrypts :checkin_address
end
