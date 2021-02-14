# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SwitchDetonationWorker, type: :service do
  it 'calls the service' do
    switch = create(:switch)

    expect_any_instance_of(SwitchDetonationService).to receive(:perform)

    Sidekiq::Testing.inline! do
      described_class.perform_async(switch.id)
    end
  end
end
