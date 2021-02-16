# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SwitchDetonationService, type: :service do
  describe 'not being forced' do
    it 'raises an exception if the switch is still alive' do
      switch = create(:switch)

      expect { described_class.perform(switch: switch) }.to raise_error(RuntimeError, /prematurely/)
    end

    it 'raises an exception if the switch has already detonated' do
      switch = create(:switch, detonated: true)
      create_list(:heartbeat, 10, switch: switch)

      expect { described_class.perform(switch: switch) }.to raise_error(RuntimeError, /detonated/)
    end

    it 'sends an email to each switch destination' do
      switch = create(:switch)
      create(:switch_destination, switch: switch)
      create_list(:heartbeat, 10, switch: switch)

      Sidekiq::Testing.inline! do
        expect_any_instance_of(SwitchDetonationMailer).to receive(:send_switch_data_to_switch_destination) # rubocop:disable RSpec/AnyInstance
        described_class.perform(switch: switch)
      end
    end

    it 'updates each switch destination as being notified' do
      switch = create(:switch)
      switch_destination = create(:switch_destination, switch: switch)
      create_list(:heartbeat, 10, switch: switch)

      Sidekiq::Testing.inline! do
        described_class.perform(switch: switch)
        expect(switch_destination.reload.switch_destination_notified).to eq(true)
      end
    end

    it 'updates the switch as detonated' do
      switch = create(:switch)
      create(:switch_destination, switch: switch)
      create_list(:heartbeat, 10, switch: switch)

      Sidekiq::Testing.inline! do
        described_class.perform(switch: switch)
        expect(switch.reload.detonated).to eq(true)
      end
    end
  end

  describe 'being forced' do
    it 'does not raise an exception if the switch is still alive' do
      switch = create(:switch)

      expect { described_class.perform(switch: switch, force: true) }.not_to raise_error
    end

    it 'raises an exception if the switch has already detonated' do
      switch = create(:switch, detonated: true)
      create_list(:heartbeat, 10, switch: switch)

      expect { described_class.perform(switch: switch, force: true) }.to raise_error(RuntimeError, /detonated/)
    end

    it 'sends an email to each switch destination' do
      switch = create(:switch)
      create(:switch_destination, switch: switch)

      Sidekiq::Testing.inline! do
        expect_any_instance_of(SwitchDetonationMailer).to receive(:send_switch_data_to_switch_destination) # rubocop:disable RSpec/AnyInstance
        described_class.perform(switch: switch, force: true)
      end
    end

    it 'updates each switch destination as being notified' do
      switch = create(:switch)
      switch_destination = create(:switch_destination, switch: switch)

      Sidekiq::Testing.inline! do
        described_class.perform(switch: switch, force: true)
        expect(switch_destination.reload.switch_destination_notified).to eq(true)
      end
    end

    it 'updates the switch as detonated' do
      switch = create(:switch)

      Sidekiq::Testing.inline! do
        described_class.perform(switch: switch, force: true)
        expect(switch.reload.detonated).to eq(true)
      end
    end
  end
end
