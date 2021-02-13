# frozen_string_literal: true

class Heartbeat < ApplicationRecord
  belongs_to :heartbeat_destination
end
