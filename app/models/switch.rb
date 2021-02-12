class Switch < ApplicationRecord
  belongs_to :user

  encrypts :name, :content

  enum checkin_interval: { daily: 0, weekly: 1, monthly: 2 }
end
