# frozen_string_literal: true

class ReceiveHeartbeatService < ApplicationService
  def perform(heartbeat)
    return if heartbeat.heartbeat_confirmed?

    heartbeat.update(heartbeat_confirmed: true)
  end
end
