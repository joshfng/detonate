# frozen_string_literal: true

user = User.create(
  email: 'josh@joshfrye.com',
  password: '123456789012',
  confirmed_at: Time.zone.now,
  admin: true
)

switch = Switch.create(
  user: user,
  name: 'My Switch',
  content: 'Super Secret Info',
  max_missed_heartbeats: 2
)

switch.switch_destinations.create(
  switch_destination_type: :email,
  switch_destination_address: 'josh@joshfrye.com'
)

switch.heartbeat_destinations.create(
  heartbeat_destination_type: :email,
  heartbeat_destination_address: 'josh@joshfrye.com'
)
