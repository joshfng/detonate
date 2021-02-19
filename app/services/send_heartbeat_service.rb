# frozen_string_literal: true

class SendHeartbeatService < ApplicationService
  attr_reader :switch

  def perform(switch)
    @switch = switch
    return false if switch.detonated?

    Rails.logger.info("Sending heartbeats - switch #{@switch.id}")

    unless heartbeat_due?
      Rails.logger.info("No heartbeat due - switch #{@switch.id}")
      return false
    end

    proccess_heartbeat

    true
  end

  def heartbeat_due?
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
    return if switch.heartbeats.where(confirmed: false).none?

    switch.increment(:missed_heartbeats)
    switch.save
  end

  def proccess_heartbeat
    Rails.logger.info("Processing heartbeat for switch - #{@switch.id}")

    if switch.alive?
      mark_missed_heartbeats
      send_switch_heartbeat
    else
      SwitchDetonationService.perform(switch: switch, force: false)
    end
  end

  def send_switch_heartbeat
    heartbeat = Heartbeat.create!(switch: switch)

    Rails.logger.info("Sending heartbeat email for switch - #{@switch.id}")
    HeartbeatMailer.with(heartbeat: heartbeat).send_heartbeat.deliver_now
  end
end
