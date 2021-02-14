# frozen_string_literal: true

class HeartbeatDestinationsController < ApplicationController
  before_action :set_switch
  before_action :set_heartbeat_destination, only: %i[show edit update destroy]

  def index
    @heartbeat_destinations = @switch.heartbeat_destinations.all
  end

  def show; end

  def new
    @heartbeat_destination = @switch.heartbeat_destinations.new
  end

  def edit; end

  def create
    @heartbeat_destination = @switch.heartbeat_destinations.new(heartbeat_destination_params)

    respond_to do |format|
      if @heartbeat_destination.save
        format.html { redirect_to @heartbeat_destination, notice: 'Heartbeat Destination was successfully created.' }
        format.json { render :show, status: :created, location: @heartbeat_destination }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heartbeat_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @heartbeat_destination.update(heartbeat_destination_params)
        format.html { redirect_to @heartbeat_destination, notice: 'Heartbeat Destination was successfully updated.' }
        format.json { render :show, status: :ok, location: @heartbeat_destination }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heartbeat_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @heartbeat_destination.destroy
    respond_to do |format|
      format.html do
        redirect_to heartbeat_destinations_url, notice: 'Heartbeat Destination was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_switch
    @switch = current_user.switches.find(params[:switch_id])
  end

  def set_heartbeat_destination
    @heartbeat_destination = @switch.heartbeat_destinations.find(params[:id])
  end

  def heartbeat_destination_params
    params.require(:heartbeat_destination).permit(:hearbeat_type, :heartbeat_destination_address)
  end
end
