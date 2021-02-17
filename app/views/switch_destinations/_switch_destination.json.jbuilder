# frozen_string_literal: true

json.extract! switch_destination,
              :id,
              :switch_id,
              :switch_destination_type,
              :switch_destination_address_ciphertext,
              :created_at,
              :updated_at

json.url switch_destination_url(switch_destination, format: :json)
