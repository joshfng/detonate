# frozen_string_literal: true

FactoryBot.define do
  factory :switch do
    association :user
    name { 'My Switch' }
    content { 'My Secret Content' }
    heartbeat_interval { :daily }
    max_missed_heartbeats { 2 }
    detonated { false }
    sequence :heartbeat_address do |n|
      "user#{n}@detonateapp.com"
    end
    sequence :switch_address do |n|
      "user#{n}@detonateapp.com"
    end
  end
end
