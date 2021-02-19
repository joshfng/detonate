# frozen_string_literal: true

class SwitchDetonationMailer < ApplicationMailer
  def send_switch_data_to_switch_address
    @switch = params[:switch]

    mail(to: @switch.switch_address, subject: 'Someone has sent you sensitive data')
  end
end
