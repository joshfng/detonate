# frozen_string_literal: true

FactoryBot.define do
  factory :switch_destination do
    association :switch
    switch_destination_type { :email }
    switch_destination_address { 'switch_destination@detonateapp.com' }
    switch_destination_notified { false }
  end
end
