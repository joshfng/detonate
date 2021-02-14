# frozen_string_literal: true

class SwitchDetonationWorker
  include Sidekiq::Worker

  sidekiq_options backtrace: true

  def perform(switch_id, force = false) # rubocop:disable Style/OptionalBooleanParameter
    switch = Switch.find(switch_id)

    SwitchDetonationService.perform(switch: switch, force: force)
  end
end
