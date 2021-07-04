# frozen_string_literal: true

class SendHeartbeatWorker
  include Sidekiq::Worker

  sidekiq_options backtrace: true

  def perform(switch_id)
    switch = Switch.find(switch_id)

    SendHeartbeatService.perform(switch: switch)
  end
end
