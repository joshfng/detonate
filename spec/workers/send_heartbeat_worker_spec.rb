# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendHeartbeatWorker, type: :service do
  it 'calls the service' do
    switch = create(:switch)

    expect_any_instance_of(SendHeartbeatService).to receive(:perform)

    Sidekiq::Testing.inline! do
      described_class.perform_async(switch.id)
    end
  end
end
