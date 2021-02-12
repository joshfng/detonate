json.extract! switch, :id, :user_id, :name, :content, :checkin_interval, :max_missed_checks, :missed_checks, :checkin_window, :created_at, :updated_at
json.url switch_url(switch, format: :json)
