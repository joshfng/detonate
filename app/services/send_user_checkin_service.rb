# frozen_string_literal: true

class SendUserCheckinService < ApplicationService
  def perform(switch)
    return if switch.checkin_interval == :weekly && Time.zone.today != Time.zone.today.beginning_of_week
    return if switch.checkin_interval == :monthly && Time.zone.today != Time.zone.today.beginning_of_month

    switch.checkins.find_each { |c| proccess_checkin(c) }
  end

  def proccess_checkin(checkin)
    verify_previous_checkin(checkin)
    switch_is_alive = switch_alive?(checkin.switch)

    if switch_is_alive
      send_current_checkins(checkin)
    else
      release_switch(checkin.switch)
    end
  end

  def verify_previous_checkin(checkin)
    previous_checkin = checkin.user_checkins.order(created_at: :desc).first

    return if !previous_checkin || previous_checkin.checkin_confirmed

    # Previous checkin is not confirmed. Mark the switch `missed_checks`
    checkin.switch.update(missed_checks: checkin.switch.missed_checks += 1)
  end

  def switch_alive?(switch)
    switch.reload

    max_missed_checks = switch.max_missed_checks
    missed_checks = switch.missed_checks

    missed_checks < max_missed_checks
  end

  def release_switch(switch)
    ReleaseSwitchService.perform(switch: switch)
  end

  def send_current_checkins(checkin)
    case checkin.checkin_type
    when 'email'
      send_checkin_email(checkin)
    end
  end

  def send_checkin_email(checkin)
    user_checkin = checkin.user_checkins.create

    CheckinMailer.with(user_checkin: user_checkin).user_checkin.deliver_now
  end
end
