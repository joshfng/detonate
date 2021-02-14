# frozen_string_literal: true

FactoryBot.define do
  factory :heartbeat do
    association :switch
    association :heartbeat_destination
    heartbeat_confirmed { false }
  end
end
