# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeartbeatMailer, type: :mailer do
  describe 'send_heartbeat' do
    let(:heartbeat) { create(:heartbeat) }

    let(:mail) do
      described_class
        .with(heartbeat:)
        .send_heartbeat
    end

    it 'renders the headers' do
      expect(mail.subject).to be('Heartbeat Attempt')
      expect(mail.to).to be([heartbeat.switch.heartbeat_address])
      expect(mail.from).to be(['noreply@detonateapp.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('This is an attempt from')
    end
  end
end
