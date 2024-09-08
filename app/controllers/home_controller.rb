# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    return redirect_to(switches_path) if current_user
  end
end
