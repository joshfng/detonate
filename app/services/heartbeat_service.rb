# frozen_string_literal: true

class HeartbeatService < ApplicationService
  def perform(heartbeat)
    heartbeat.update(heartbeat_confirmed: true)
    heartbeat.heartbeat_destination.switch.update(alive: true)
    heartbeat.hearbeat_destination.switch.update(missed_heartbeats: 0)
  end
end
