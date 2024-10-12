# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiveHeartbeatService, type: :service do
  it 'does nothing for confirmed heartbeats' do
    heartbeat = create(:heartbeat, confirmed: true)

    expect(described_class.perform(heartbeat: heartbeat)).to be(false)
  end

  it 'does nothing for detonated switches' do
    heartbeat = create(:heartbeat)
    heartbeat.switch.update(detonated: true)

    expect(described_class.perform(heartbeat: heartbeat)).to be(false)
  end

  it 'confirms heartbeats' do
    heartbeat = create(:heartbeat, confirmed: false)
    heartbeat.switch.update(max_missed_heartbeats: 10)
    create_list(:heartbeat, 5, switch: heartbeat.switch)

    expect(described_class.perform(heartbeat: heartbeat)).to be(true)
    expect(heartbeat.reload.confirmed?).to be(true)
    expect(heartbeat.switch.heartbeats.where(confirmed: false).count).to be(0)
    expect(heartbeat.switch.missed_heartbeats).to be(0)
  end
end
