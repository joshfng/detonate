# frozen_string_literal: true

json.extract! switch, :id, :user_id, :name, :content, :heartbeat_interval, :max_missed_heartbeats, :missed_heartbeats,
              :created_at, :updated_at
json.url switch_url(switch, format: :json)
