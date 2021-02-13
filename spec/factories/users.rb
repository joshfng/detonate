# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'testuser@detonateapp.com' }
    password { 123_456_789_012 }
  end
end
