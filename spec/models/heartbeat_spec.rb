# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heartbeat, type: :model do
  describe 'validations' do
    it 'ensures a switch exists' do
      heartbeat = build(:heartbeat, switch: nil)
      expect(heartbeat.valid?).to eq(false)

      heartbeat.switch = create(:switch)
      expect(heartbeat.valid?).to eq(true)
    end

    it 'ensures a heartbeat_destination exists' do
      heartbeat = build(:heartbeat, heartbeat_destination: nil)
      expect(heartbeat.valid?).to eq(false)

      heartbeat.heartbeat_destination = create(:heartbeat_destination)
      expect(heartbeat.valid?).to eq(true)
    end
  end
end
