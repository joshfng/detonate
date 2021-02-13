# frozen_string_literal: true

json.extract! checkin, :id, :switch_id, :checkin_type, :checkin_address_ciphertext, :checkin_confirmed, :created_at,
              :updated_at
json.url checkin_url(checkin, format: :json)
