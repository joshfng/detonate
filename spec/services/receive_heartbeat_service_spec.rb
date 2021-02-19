# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiveHeartbeatService, type: :service do
  it 'does nothing for confirmed heartbeats' do
    heartbeat = create(:heartbeat, heartbeat_confirmed: true)

    expect(described_class.perform(heartbeat)).to eq(false)
  end

  it 'does nothing for detonated switches' do
    heartbeat = create(:heartbeat)
    heartbeat.switch.update(detonated: true)

    expect(described_class.perform(heartbeat)).to eq(false)
  end

  it 'confirms heartbeats' do
    heartbeat = create(:heartbeat, heartbeat_confirmed: false)
    heartbeat.switch.update(max_missed_heartbeats: 10)
    create_list(:heartbeat, 5, switch: heartbeat.switch, heartbeat_destination: heartbeat.heartbeat_destination)

    expect(described_class.perform(heartbeat)).to eq(true)
    expect(heartbeat.reload.heartbeat_confirmed).to eq(true)
    expect(heartbeat.switch.heartbeats.where(heartbeat_confirmed: false).count).to eq(0)
  end
end
