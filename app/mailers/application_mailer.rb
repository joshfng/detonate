# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@detonateapp.com'
  layout 'mailer'
end
