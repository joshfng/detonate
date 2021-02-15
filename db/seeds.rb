# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'josh@joshfrye.com', password: '123456789012')
switch = Switch.create(user: user, name: 'My Switch', content: 'Super Secret Info', max_missed_heartbeats: 2)
switch.switch_destinations.create(switch_destination_address: 'josh@joshfrye.com')
switch.heartbeat_destinations.create(heartbeat_destination_address: 'josh@joshfrye.com')
