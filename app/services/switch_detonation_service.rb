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
    raise "Tried to detonate switch #{switch.id} that has already detonated" if switch.detonated?

    Rails.logger.info("Detonating switch #{@switch.id}")

    switch.switch_destinations.find_each do |switch_destination|
      detonate_switch(switch_destination)
    end

    switch.update(detonated: true)
  end

  def detonate_switch(switch_destination)
    case switch_destination.switch_destination_type
    when 'email'
      Rails.logger.info("Sending switch content to switch destination #{switch_destination.id} - #{@switch.id}")

      SwitchDetonationMailer
        .with(switch_destination: switch_destination)
        .send_switch_data_to_switch_destination
        .deliver_later
    end

    Rails.logger.info("Marking switch as detonated - #{@switch.id}")
    switch_destination.update(switch_destination_notified: true)
  end
end
