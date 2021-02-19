# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendHeartbeatService, type: :service do
  it 'is allowed to send' do
    switch = create(:switch, heartbeat_interval: :daily)

    expect(described_class.perform(switch)).to eq(true)

    switch.update(heartbeat_interval: :weekly)
    Timecop.freeze(Time.zone.today.beginning_of_week + 1.day) do
      expect(described_class.perform(switch)).to eq(false)
    end
  end

  it 'sends a heartbeat when the switch is still alive' do
    switch = create(:switch, heartbeat_interval: :daily, max_missed_heartbeats: 2)
    create(:switch_destination, switch: switch)
    create(:heartbeat_destination, switch: switch)

    Sidekiq::Testing.inline! do
      expect_any_instance_of(HeartbeatMailer).to receive(:send_heartbeat) # rubocop:disable RSpec/AnyInstance
      described_class.perform(switch)
    end
  end

  it 'detonates the switch when too many heartbeats have been missed' do
    switch = create(:switch, heartbeat_interval: :daily, max_missed_heartbeats: 2, missed_heartbeats: 2)
    heartbeat_destination = create(:heartbeat_destination, switch: switch)
    create(:switch_destination, switch: switch)
    create_list(:heartbeat, 2, switch: switch, heartbeat_destination: heartbeat_destination)

    expect_any_instance_of(SwitchDetonationService).to receive(:perform) # rubocop:disable RSpec/AnyInstance
    described_class.perform(switch)
  end

  describe 'weekly intervals' do
    it 'is allowed to send only on the first day of the week' do
      switch = create(:switch, heartbeat_interval: :weekly)

      Timecop.freeze(Time.zone.today.beginning_of_week + 1.day) do
        expect(described_class.perform(switch)).to eq(false)
      end

      Timecop.freeze(Time.zone.today.beginning_of_week) do
        expect(described_class.perform(switch)).to eq(true)
      end
    end
  end

  describe 'monthly intervals' do
    it 'is allowed to send only on the first day of the month' do
      switch = create(:switch, heartbeat_interval: :monthly)

      Timecop.freeze(Time.zone.today.beginning_of_month + 1.day) do
        expect(described_class.perform(switch)).to eq(false)
      end

      Timecop.freeze(Time.zone.today.beginning_of_month) do
        expect(described_class.perform(switch)).to eq(true)
      end
    end
  end
end
