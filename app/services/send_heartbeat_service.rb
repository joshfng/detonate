# frozen_string_literal: true

class SendHeartbeatService < ApplicationService
  def perform(switch)
    return if switch.heartbeat_interval == :weekly && Time.zone.today != Time.zone.today.beginning_of_week
    return if switch.heartbeat_interval == :monthly && Time.zone.today != Time.zone.today.beginning_of_month

    switch.heartbeat_destinations.find_each { |heartbeat_destination| proccess_heartbeat(heartbeat_destination) }
  end

  def process_heartbeat_destination(heartbeat_destination)
    verify_previous_heartbeat(heartbeat_destination)
    switch_is_alive = switch_alive?(heartbeat_destination.switch)

    if switch_is_alive
      send_heartbeat(heartbeat_destination)
    else
      release_switch(heartbeat_destination.switch)
    end
  end

  def verify_previous_heartbeat(heartbeat_destination)
    previous_heartbeat = heartbeat_destination.heartbeats.order(created_at: :desc).first

    return if !previous_heartbeat || previous_heartbeat.heartbeat_confirmed?

    # Previous heartbeat is not confirmed. Mark the switch `missed_heartbeats`
    heartbeat_destination.switch.update(missed_heartbeats: heartbeat_destination.switch.missed_heartbeats += 1)
  end

  def switch_alive?(switch)
    switch.reload

    max_missed_heartbeats = switch.max_missed_heartbeats
    missed_heartbeats = switch.missed_heartbeats

    missed_heartbeats < max_missed_heartbeats
  end

  def release_switch(switch)
    ReleaseSwitchService.perform(switch: switch)
  end

  def send_heartbeat(heartbeat_destination)
    case heartbeat_destination.heartbeat_type
    when 'email'
      send_heartbeat_email(heartbeat_destination)
    end
  end

  def send_heartbeat_email(heartbeat_destination)
    heartbeat = heartbeat_destination.heartbeats.create

    HeartbeatMailer.with(heartbeat: heartbeat).heartbeat.deliver_now
  end
end
