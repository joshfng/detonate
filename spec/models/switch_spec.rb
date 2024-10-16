# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Switch, type: :model do
  describe 'validations' do
    it 'ensures a user exists' do
      switch = build(:switch, user: nil)
      expect(switch.valid?).to be(false)

      switch.user = create(:user)
      expect(switch.valid?).to be(true)
    end

    it 'ensures a name exists' do
      switch = build(:switch, name: nil)
      expect(switch.valid?).to be(false)

      switch.name = 'My Switch'
      expect(switch.valid?).to be(true)
    end

    it 'ensures content exists' do
      switch = build(:switch, content: nil)
      expect(switch.valid?).to be(false)

      switch.content = 'My Content'
      expect(switch.valid?).to be(true)
    end

    it 'ensures a heartbeat_interval exists' do
      switch = build(:switch, heartbeat_interval: nil)
      expect(switch.valid?).to be(false)

      switch.heartbeat_interval = :daily
      expect(switch.valid?).to be(true)
    end

    it 'ensures a heartbeat_interval is allowed' do
      switch = build(:switch, heartbeat_interval: nil)

      expect do
        switch.heartbeat_interval = :gibberish
      end.to raise_error(ArgumentError)

      switch.heartbeat_interval = :weekly
      expect(switch.valid?).to be(true)
    end

    it 'ensures max_missed_heartbeats is valid' do
      switch = build(:switch, max_missed_heartbeats: nil)
      expect(switch.valid?).to be(false)

      switch.max_missed_heartbeats = 1.1
      expect(switch.valid?).to be(false)

      switch.max_missed_heartbeats = 1
      expect(switch.valid?).to be(true)
    end

    it 'ensures heartbeat_address is valid' do
      switch = build(:switch, heartbeat_address: nil)
      expect(switch.valid?).to be(false)

      switch = build(:switch, heartbeat_address: 'test')
      expect(switch.valid?).to be(false)

      switch = build(:switch, heartbeat_address: 'nobody@detonateapp.com')
      expect(switch.valid?).to be(true)
    end

    it 'ensures switch_address is valid' do
      switch = build(:switch, switch_address: nil)
      expect(switch.valid?).to be(false)

      switch = build(:switch, switch_address: 'test')
      expect(switch.valid?).to be(false)

      switch = build(:switch, switch_address: 'nobody@detonateapp.com')
      expect(switch.valid?).to be(true)
    end
  end

  describe 'dead or alive' do
    it 'tracks a switch as alive' do
      switch = create(:switch)

      expect(switch.alive?).to be(true)
      expect(switch.dead?).to be(false)
    end

    it 'tracks a switch as dead' do
      switch = create(:switch, max_missed_heartbeats: 1, missed_heartbeats: 1)

      expect(switch.alive?).to be(false)
      expect(switch.dead?).to be(true)
    end
  end
end
