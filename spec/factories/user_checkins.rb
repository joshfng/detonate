# frozen_string_literal: true

FactoryBot.define do
  factory :user_checkin do
    checkin_id { 'MyText' }
    checkin_confirmed { false }
  end
end
