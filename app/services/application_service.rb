# frozen_string_literal: true

class ApplicationService
  # include Rails.application.routes.url_helpers

  def self.perform(*args)
    new.perform(*args)
  end

  protected

  # def default_url_options
  #   Rails.application.config.action_mailer.default_url_options
  # end
end
