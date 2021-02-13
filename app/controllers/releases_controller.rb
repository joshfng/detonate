# frozen_string_literal: true

class ReleasesController < ApplicationController
  before_action :set_switch
  before_action :set_release, only: %i[show edit update destroy]

  def index
    @releases = @switch.releases.all
  end

  def show; end

  def new
    @release = @switch.releases.new
  end

  def edit; end

  def create
    @release = @switch.releases.new(release_params)

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: 'Release was successfully created.' }
        format.json { render :show, status: :created, location: @release }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @release.update(release_params)
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { render :show, status: :ok, location: @release }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @release.destroy
    respond_to do |format|
      format.html { redirect_to releases_url, notice: 'Release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_switch
    @switch = current_user.switches.find(params[:switch_id])
  end

  def set_release
    @release = @switch.releases.find(params[:id])
  end

  def release_params
    params.require(:release).permit(:switch_id, :release_type, :release_address)
  end
end
