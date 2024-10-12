# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heartbeat, type: :model do
  describe 'validations' do
    it 'ensures a switch exists' do
      heartbeat = build(:heartbeat, switch: nil)
      expect(heartbeat.valid?).to be(false)

      heartbeat.switch = create(:switch)
      expect(heartbeat.valid?).to be(true)
    end
  end
end
