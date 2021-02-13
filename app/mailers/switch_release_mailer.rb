# frozen_string_literal: true

class SwitchReleaseMailer < ApplicationMailer
  def send_switch_data_to_release
    @release = params[:release]

    mail(to: @release.release_address, subject: 'Someone has sent you sensitive data')
  end
end
