# frozen_string_literal: true

class SwitchDetonationService < ApplicationService
  attr_reader :switch, :force

  def perform(switch:, force: false)
    @switch = switch
    @force = force

    detonate_switches
  end

  def detonate_switches
    raise "Tried to detonate switch #{switch.id} prematurely" if switch.alive? && !force
    return false if switch.detonated?

    Rails.logger.info("Detonating switch #{@switch.id}")

    detonate_switch
  end

  def detonate_switch
    Rails.logger.info("Sending switch content to switch - #{@switch.id}")

    SwitchDetonationMailer
      .with(switch:)
      .send_switch_data_to_switch_address
      .deliver_now

    Rails.logger.info("Marking switch as detonated - #{@switch.id}")
    switch.update(detonated: true, switch_address_notified: true)
  end
end
