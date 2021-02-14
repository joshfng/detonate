# frozen_string_literal: true

class ScheduleSwitchHeartbeatsWorker
  include Sidekiq::Worker

  sidekiq_options backtrace: true

  def perform
    Switch.where(detonated: false).find_each do |switch|
      SendHeartbeatWorker.perform_async(switch.id)
    end
  end
end
