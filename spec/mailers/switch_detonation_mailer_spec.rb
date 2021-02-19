# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SwitchDetonationMailer, type: :mailer do
  describe 'send_switch_data_to_switch_address' do
    let(:switch) { create(:switch) }

    let(:mail) do
      described_class
        .with(switch: switch)
        .send_switch_data_to_switch_address
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Someone has sent you sensitive data')
      expect(mail.to).to eq([switch.switch_address])
      expect(mail.from).to eq(['noreply@detonateapp.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Someone has sent you sensitive data with Detonate')
    end
  end
end
