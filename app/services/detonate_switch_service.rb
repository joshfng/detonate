# frozen_string_literal: true

class DetonateSwitchService < ApplicationService
  def perform(switch)
    ReleaseSwitchService.perform(switch: switch, force: true)

    switch.reload
    switch.update(alive: false)
    switch.update(detonated: true)
  end
end
