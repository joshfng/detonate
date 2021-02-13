# frozen_string_literal: true

class ReleaseSwitchService < ApplicationService
  attr_reader :switch, :force

  def perform(switch:, force: false)
    @switch = switch
    @force = force

    confirm_switch_should_be_released unless force
    release_switch
  end

  def confirm_switch_should_be_released
    missed_checks = switch.missed_checks
    max_missed_checks = switch.max_missed_checks

    raise "Tried to release switch #{switch.id} prematurely" if missed_checks < max_missed_checks

    switch.update(alive: false)
  end

  def release_switch
    return if switch.alive? && !force

    switch.releases.find_each do |release|
      SwitchReleaseMailer.with(release: release).send_switch_data_to_release.deliver_now
      release.update(release_sent: true)
    end
  end
end
