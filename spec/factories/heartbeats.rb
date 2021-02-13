# frozen_string_literal: true

FactoryBot.define do
  factory :heartbeat do
    heartbeat_destination_id { 'MyText' }
    heartbeat_confirmed { false }
  end
end
