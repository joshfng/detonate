# frozen_string_literal: true

class SwitchesController < ApplicationController
  before_action :set_switch, only: %i[show edit update destroy]

  def index
    @switches = current_user.switches.all
  end

  def show; end

  def new
    @switch = current_user.switches.new
  end

  def edit; end

  def create
    @switch = current_user.switches.new(switch_params)
    @switch.content.strip!

    respond_to do |format|
      if @switch.save
        SendHeartbeatWorker.perform_async(@switch.id)

        format.html { redirect_to @switch, notice: 'Switch was successfully created.' }
        format.json { render :show, status: :created, location: @switch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @switch.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      # If editing the switch, mark it as alive and confirm all prior hearbeats
      # The user editing the switch is a signal they are fine

      attributes = switch_params.merge(missed_heartbeats: 0)
      attributes[:content].strip!

      if @switch.update(attributes)
        @switch.heartbeats.update_all(confirmed: true) # rubocop:disable Rails/SkipsModelValidations

        format.html { redirect_to @switch, notice: 'Switch was successfully updated.' }
        format.json { render :show, status: :ok, location: @switch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @switch.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @switch.destroy
    respond_to do |format|
      format.html { redirect_to switches_url, notice: 'Switch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_switch
    @switch = current_user.switches.find(params[:id])
  end

  def switch_params
    params
      .require(:switch)
      .permit(
        :name,
        :content,
        :heartbeat_interval,
        :max_missed_heartbeats,
        :heartbeat_address,
        :switch_address
      )
  end
end
