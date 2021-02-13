# frozen_string_literal: true

json.extract! release, :id, :switch_id, :release_type, :release_address_ciphertext, :release_sent, :created_at,
              :updated_at
json.url release_url(release, format: :json)
