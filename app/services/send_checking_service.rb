# frozen_string_literal: true

class SendCheckinService < ApplicationService
  def perform(switch)
    switch.checkins.find_each { |c| proccess_checkin(c) }
  end

  def proccess_checkin(checkin); end
end
