# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@detonateapp.com"
    end

    password { 123_456_789_012 }
  end
end
