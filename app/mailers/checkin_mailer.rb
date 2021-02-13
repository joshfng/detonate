# frozen_string_literal: true

class CheckinMailer < ApplicationMailer
  def user_checkin
    @user_checkin = params[:user_checkin]
    @url = "http://detonateapp.com/user-checkins/#{@user_checkin.id}"

    mail(to: @user_checkin.checkin.checkin_address, subject: 'Checkin With Detonate')
  end
end
