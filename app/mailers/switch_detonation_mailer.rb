# frozen_string_literal: true

class SwitchDetonationMailer < ApplicationMailer
  def send_switch_data_to_switch_destination
    @switch_destination = params[:switch_destination]

    mail(to: @switch_destination.switch_destination_address, subject: 'Someone has sent you sensitive data')
  end
end
