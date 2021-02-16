# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeartbeatDestination, type: :model do
  describe 'validations' do
    it 'ensures a switch exists' do
      heartbeat_destination = build(:heartbeat_destination, switch: nil)
      expect(heartbeat_destination.valid?).to eq(false)

      heartbeat_destination.switch = create(:switch)
      expect(heartbeat_destination.valid?).to eq(true)
    end

    it 'ensures a heartbeat_destination_type exists' do
      heartbeat_destination = build(:heartbeat_destination, heartbeat_destination_type: nil)
      expect(heartbeat_destination.valid?).to eq(false)

      heartbeat_destination.heartbeat_destination_type = :email
      expect(heartbeat_destination.valid?).to eq(true)
    end

    it 'ensures a heartbeat_destination_type is allowed' do
      heartbeat_destination = build(:heartbeat_destination, heartbeat_destination_type: nil)

      expect do
        heartbeat_destination.heartbeat_destination_type = :gibberish
      end.to raise_error(ArgumentError)

      heartbeat_destination.heartbeat_destination_type = :email
      expect(heartbeat_destination.valid?).to eq(true)
    end

    it 'ensures a heartbeat_destination_address exists' do
      heartbeat_destination = build(:heartbeat_destination, heartbeat_destination_address: nil)
      expect(heartbeat_destination.valid?).to eq(false)

      heartbeat_destination.heartbeat_destination_address = 'someone@detonateapp.com'
      expect(heartbeat_destination.valid?).to eq(true)
    end

    it 'ensures a heartbeat_destination_address of type email is an email address' do
      heartbeat_destination = build(:heartbeat_destination, heartbeat_destination_address: 'test')
      expect(heartbeat_destination.valid?).to eq(false)

      heartbeat_destination.heartbeat_destination_address = 'someone@detonateapp.com'
      expect(heartbeat_destination.valid?).to eq(true)
    end
  end
end
