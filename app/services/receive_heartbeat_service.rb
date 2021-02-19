# frozen_string_literal: true

class ReceiveHeartbeatService < ApplicationService
  def perform(heartbeat)
    return false if heartbeat.heartbeat_confirmed?
    return false if heartbeat.switch.detonated?

    heartbeat.switch.heartbeats.update_all(heartbeat_confirmed: true) # rubocop:disable Rails/SkipsModelValidations
    heartbeat.switch.update(missed_heartbeats: 0)

    true
  end
end
