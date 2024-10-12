# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to(switches_path) if current_user
  end
end
