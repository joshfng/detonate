# frozen_string_literal: true

json.extract! switch, :id, :user_id, :name, :content, :heartbeat_interval, :max_missed_heartbeats,
              :created_at, :updated_at, :heartbeat_address, :switch_address
json.url switch_url(switch, format: :json)
