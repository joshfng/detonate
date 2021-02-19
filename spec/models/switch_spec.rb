# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Switch, type: :model do
  describe 'validations' do
    it 'ensures a user exists' do
      switch = build(:switch, user: nil)
      expect(switch.valid?).to eq(false)

      switch.user = create(:user)
      expect(switch.valid?).to eq(true)
    end

    it 'ensures a heartbeat_interval exists' do
      switch = build(:switch, heartbeat_interval: nil)
      expect(switch.valid?).to eq(false)

      switch.heartbeat_interval = :daily
      expect(switch.valid?).to eq(true)
    end

    it 'ensures a heartbeat_interval is allowed' do
      switch = build(:switch, heartbeat_interval: nil)

      expect do
        switch.heartbeat_interval = :gibberish
      end.to raise_error(ArgumentError)

      switch.heartbeat_interval = :weekly
      expect(switch.valid?).to eq(true)
    end

    it 'ensures a max_missed_heartbeats is valid' do
      switch = build(:switch, max_missed_heartbeats: nil)
      expect(switch.valid?).to eq(false)

      switch.max_missed_heartbeats = 1.1
      expect(switch.valid?).to eq(false)

      switch.max_missed_heartbeats = 1
      expect(switch.valid?).to eq(true)
    end

    it 'ensures a missed_heartbeats is valid' do
      switch = build(:switch, missed_heartbeats: nil)
      expect(switch.valid?).to eq(false)

      switch.missed_heartbeats = 1.1
      expect(switch.valid?).to eq(false)

      switch.missed_heartbeats = 1
      expect(switch.valid?).to eq(true)
    end
  end

  describe 'dead or alive' do
    it 'tracks a switch as alive' do
      switch = create(:switch)

      expect(switch.alive?).to eq(true)
      expect(switch.dead?).to eq(false)
    end

    it 'tracks a switch as dead' do
      switch = create(:switch, max_missed_heartbeats: 1, missed_heartbeats: 1)

      expect(switch.alive?).to eq(false)
      expect(switch.dead?).to eq(true)
    end
  end
end
