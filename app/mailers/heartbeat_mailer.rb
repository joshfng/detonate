# frozen_string_literal: true

class HeartbeatMailer < ApplicationMailer
  def send_heartbeat
    @heartbeat = params[:heartbeat]
    @url = heartbeat_receive_url(@heartbeat.id)

    mail(
      to: @heartbeat.switch.heartbeat_address,
      subject: 'Heartbeat Attempt'
    )
  end
end
