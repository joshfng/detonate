# frozen_string_literal: true

class UserCheckinsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkin]

  def checkin
    @user_checkin = UserCheckin.find(params[:id])

    UserCheckinService.perform(@user_checkin) unless @user_checkin.checkin_confirmed?
  end
end
