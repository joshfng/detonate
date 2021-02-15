# frozen_string_literal: true

class ReceiveHeartbeatService < ApplicationService
  def perform(heartbeat)
    return false if heartbeat.heartbeat_confirmed?
    return false if heartbeat.switch.dead?
    return false if heartbeat.switch.detonated?

    heartbeat.switch.heartbeats.update_all(heartbeat_confirmed: true) # rubocop:disable Rails/SkipsModelValidations

    true
  end
end
