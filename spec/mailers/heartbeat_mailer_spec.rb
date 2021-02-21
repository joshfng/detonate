# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeartbeatMailer, type: :mailer do
  describe 'send_heartbeat' do
    let(:heartbeat) { create(:heartbeat) }

    let(:mail) do
      described_class
        .with(heartbeat: heartbeat)
        .send_heartbeat
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Heartbeat Attempt')
      expect(mail.to).to eq([heartbeat.switch.heartbeat_address])
      expect(mail.from).to eq(['noreply@detonateapp.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('This is an attempt from')
    end
  end
end
