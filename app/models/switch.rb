# frozen_string_literal: true

class Switch < ApplicationRecord
  belongs_to :user

  has_many :checkins, dependent: destroy
  has_many :releases, dependent: destroy

  encrypts :name, :content

  enum checkin_interval: { daily: 0, weekly: 1, monthly: 2 }
end
