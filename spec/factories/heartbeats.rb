# frozen_string_literal: true

FactoryBot.define do
  factory :heartbeat do
    association :switch
    confirmed { false }
  end
end
