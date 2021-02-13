# frozen_string_literal: true

class HeartbeatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:heartbeat]

  def heartbeat
    @heartbeat = Heartbeat.find(params[:id])

    HearbeatService.perform(@heartbeat) unless @heartbeat.heartbeat_confirmed?
  end
end
