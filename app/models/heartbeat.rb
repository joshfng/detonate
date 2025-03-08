# frozen_string_literal: true

class Heartbeat < ApplicationRecord
  belongs_to :switch

  validates :switch, presence: true # rubocop:disable Rails/RedundantPresenceValidationOnBelongsTo
end
