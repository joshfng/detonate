# frozen_string_literal: true

class SendHeartbeatService < ApplicationService
  attr_reader :switch

  def perform(switch)
    @switch = switch
    Rails.logger.info("Sending heartbeats - switch #{@switch.id}")

    unless heartbeat_due?
      Rails.logger.info("No heartbeat due - switch #{@switch.id}")
      return false
    end

    mark_missed_heartbeats

    switch.heartbeat_destinations.find_each do |heartbeat_destination|
      proccess_heartbeat_destination(heartbeat_destination)
    end

    true
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

  def mark_missed_heartbeats
    return if switch.heartbeats.where(heartbeat_confirmed: false).none?

    switch.increment(:missed_heartbeats)
    switch.save
  end

  def proccess_heartbeat_destination(heartbeat_destination)
    Rails.logger.info("Processing heartbeat destination #{heartbeat_destination.id} - switch #{@switch.id}")

    if switch.alive?
      send_switch_heartbeat(heartbeat_destination)
    else
      SwitchDetonationService.perform(switch: switch, force: false)
    end
  end

  def send_switch_heartbeat(heartbeat_destination)
    heartbeat = Heartbeat.create!(switch: switch, heartbeat_destination: heartbeat_destination)

    case heartbeat_destination.heartbeat_destination_type
    when 'email'
      Rails.logger.info("Sending heartbeat destination email for #{heartbeat_destination.id} - switch #{@switch.id}")
      HeartbeatMailer.with(heartbeat: heartbeat).send_heartbeat.deliver_later
    end
  end
end
