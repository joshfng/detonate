# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SwitchDestination, type: :model do
  describe 'validations' do
    it 'ensures a switch exists' do
      switch_destination = build(:switch_destination, switch: nil)
      expect(switch_destination.valid?).to eq(false)

      switch_destination.switch = create(:switch)
      expect(switch_destination.valid?).to eq(true)
    end

    it 'ensures a switch_destination_type exists' do
      switch_destination = build(:switch_destination, switch_destination_type: nil)
      expect(switch_destination.valid?).to eq(false)

      switch_destination.switch_destination_type = :email
      expect(switch_destination.valid?).to eq(true)
    end

    it 'ensures a switch_destination_type is allowed' do
      switch_destination = build(:switch_destination, switch_destination_type: nil)

      expect do
        switch_destination.switch_destination_type = :gibberish
      end.to raise_error(ArgumentError)

      switch_destination.switch_destination_type = :email
      expect(switch_destination.valid?).to eq(true)
    end

    it 'ensures a switch_destination_address exists' do
      switch_destination = build(:switch_destination, switch_destination_address: nil)
      expect(switch_destination.valid?).to eq(false)

      switch_destination.switch_destination_address = 'someone@detonateapp.com'
      expect(switch_destination.valid?).to eq(true)
    end

    it 'ensures a switch_destination_address of type email is an email address' do
      switch_destination = build(:switch_destination, switch_destination_address: 'test')
      expect(switch_destination.valid?).to eq(false)

      switch_destination.switch_destination_address = 'someone@detonateapp.com'
      expect(switch_destination.valid?).to eq(true)
    end
  end
end
