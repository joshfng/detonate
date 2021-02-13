# frozen_string_literal: true

json.extract! switch, :id, :user_id, :name, :content, :checkin_interval, :max_missed_checks, :missed_checks,
              :created_at, :updated_at
json.url switch_url(switch, format: :json)
