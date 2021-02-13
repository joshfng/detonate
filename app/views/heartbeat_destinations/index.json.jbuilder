# frozen_string_literal: true

json.array! @heartbeat_destinations, partial: 'heartbeat_destination/heartbeat_destination', as: :heartbeat_destination
