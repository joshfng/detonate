# frozen_string_literal: true

FactoryBot.define do
  factory :heartbeat_destination do
    association :switch
    heartbeat_destination_type { :email }
    heartbeat_destination_address { 'hbdaddress@detonateapp.com' }
  end
end
