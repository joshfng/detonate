# frozen_string_literal: true

class CheckinsController < ApplicationController
  before_action :set_switch
  before_action :set_checkin, only: %i[show edit update destroy]

  # GET /checkins or /checkins.json
  def index
    @checkins = current_user.switches.find(params[:switch_id]).checkins.all
  end

  # GET /checkins/1 or /checkins/1.json
  def show; end

  # GET /checkins/new
  def new
    @checkin = current_user.switches.find(params[:switch_id]).checkins.new
  end

  # GET /checkins/1/edit
  def edit; end

  # POST /checkins or /checkins.json
  def create
    @checkin = current_user.switches.find(params[:switch_id]).checkins.new(checkin_params)

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
        format.json { render :show, status: :created, location: @checkin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkins/1 or /checkins/1.json
  def update
    respond_to do |format|
      if @checkin.update(checkin_params)
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1 or /checkins/1.json
  def destroy
    @checkin.destroy
    respond_to do |format|
      format.html { redirect_to checkins_url, notice: 'Checkin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_switch
    @switch = current_user.switches.find(params[:switch_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_checkin
    @checkin = @switch.checkins.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def checkin_params
    params.require(:checkin).permit(:checkin_type, :checkin_address, :checkin_confirmed)
  end
end
