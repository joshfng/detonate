# frozen_string_literal: true

json.extract! heartbeat_destination,
              :id,
              :switch_id,
              :heartbeat_destination_type,
              :heartbeat_destination_address_ciphertext,
              :created_at,
              :updated_at

json.url heartbeat_destination_url(heartbeat_destination, format: :json)
