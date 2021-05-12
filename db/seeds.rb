# frozen_string_literal: true

user = User.create!(
  email: 'joshfrye271@gmail.com',
  password: '123456789012',
  confirmed_at: Time.zone.now,
  admin: true
)

Switch.create!(
  user: user,
  name: 'My Switch',
  content: 'Super Secret Info',
  max_missed_heartbeats: 2,
  switch_address: 'joshfrye271@gmail.com',
  heartbeat_address: 'joshfrye271@gmail.com'
)
