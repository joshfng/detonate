# frozen_string_literal: true

class SendHeartbeatService < ApplicationService
  attr_reader :switch

  def perform(switch)
    @switch = switch
    Rails.logger.info("Sending heartbeats for #{@switch.id}")

    return unless heartbeat_due?

    switch.heartbeat_destinations.find_each do |heartbeat_destination|
      proccess_heartbeat_destination(heartbeat_destination)
    end
  end

  def heartbeat_due?
    return false if switch.detonated?

    case switch.heartbeat_interval
    when 'daily'
      true
    when 'weekly'
      Time.zone.today == Time.zone.today.beginning_of_week
    when 'monthly'
      Time.zone.today == Time.zone.today.beginning_of_month
    end
  end

  def proccess_heartbeat_destination(heartbeat_destination)
    if switch.alive?
      send_switch_heartbeat(heartbeat_destination)
    else
      SwitchDetonationWorker.perform_async(switch.id)
    end
  end

  def send_switch_heartbeat(heartbeat_destination)
    heartbeat = heartbeat_destination.heartbeats.create!(switch: switch)

    case heartbeat_destination.heartbeat_destination_type
    when 'email'
      HeartbeatMailer.with(heartbeat: heartbeat).send_heartbeat.deliver_later
    end
  end
end
