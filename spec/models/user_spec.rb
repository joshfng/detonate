# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires an email address' do
      user = build(:user)
      expect(user.valid?).to be(true)

      user.email = nil
      expect(user.valid?).to be(false)
    end

    it 'requires a unique email address' do
      user1 = create(:user)
      expect(user1.valid?).to be(true)

      user2 = build(:user, email: user1.email)
      expect(user2.valid?).to be(false)
    end
  end
end
