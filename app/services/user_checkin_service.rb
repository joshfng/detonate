# frozen_string_literal: true

class UserCheckinService < ApplicationService
  def perform(user_checkin)
    user_checkin.update(checkin_confirmed: true)
    user_checkin.checkin.switch.update(alive: true)
    user_checkin.checkin.switch.update(missed_checks: 0)
  end
end
