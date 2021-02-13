# frozen_string_literal: true

class HeartbeatMailer < ApplicationMailer
  def heartbeat
    @heartbeat = params[:heartbeat]
    @url = "https://detonateapp.com/heartbeats/#{@heartbeat.id}"

    mail(to: @heartbeat.heartbeat_destinations.hearbeat_address, subject: 'Heartbeat Attempt')
  end
end
