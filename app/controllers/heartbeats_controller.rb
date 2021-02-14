# frozen_string_literal: true

class HeartbeatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:receive_heartbeat]

  def receive_heartbeat
    @heartbeat = Heartbeat.find(params[:id])

    ReceiveHeartbeatService.perform(@heartbeat)
  end
end
