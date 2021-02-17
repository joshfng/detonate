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

    switch.switch_destinations.find_each do |switch_destination|
      detonate_switch(switch_destination)
    end

    switch.update(detonated: true)
  end

  def detonate_switch(switch_destination)
    case switch_destination.switch_destination_type
    when 'email'
      SwitchDetonationMailer
        .with(switch_destination: switch_destination)
        .send_switch_data_to_switch_destination
        .deliver_later
    end

    switch_destination.update(switch_destination_notified: true)
  end
end
