# frozen_string_literal: true

class SwitchDestinationsController < ApplicationController
  before_action :set_switch
  before_action :set_switch_destination, only: %i[show edit update destroy]

  # TODO: validate switch is owned by current_user

  def index
    @switch_destinations = @switch.switch_destinations.all
  end

  def show; end

  def new
    @switch_destination = @switch.switch_destinations.new
  end

  def edit; end

  def create
    @switch_destination = @switch.switch_destinations.new(switch_destination_params)

    respond_to do |format|
      if @switch_destination.save
        format.html do
          redirect_to [@switch_destination.switch, @switch_destination],
                      notice: 'Switch Destination was successfully created.'
        end
        format.json { render :show, status: :created, location: @switch_destination }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @switch_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @switch_destination.update(switch_destination_params)
        format.html do
          redirect_to [@switch_destination.switch, @switch_destination],
                      notice: 'Switch Destination was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @switch_destination }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @switch_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @switch_destination.destroy
    respond_to do |format|
      format.html do
        redirect_to switch_switch_destinations_path(@switch), notice: 'Switch Destination was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_switch
    @switch = current_user.switches.find(params[:switch_id])
  end

  def set_switch_destination
    @switch_destination = @switch.switch_destinations.find(params[:id])
  end

  def switch_destination_params
    params.require(:switch_destination).permit(:switch_id, :switch_destination_type, :switch_destination_address)
  end
end
