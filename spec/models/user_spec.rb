# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires an email address' do
      user = build(:user)

      expect(user.save).to eq(true)
    end
  end
end
