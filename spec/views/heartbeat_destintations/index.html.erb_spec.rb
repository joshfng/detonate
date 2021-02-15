# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'heartbeat_destinations/index', type: :view do
#   before do
#     assign(:heartbeat_destination, [
#              HeartbeatDestination.create!(
#                switch: nil,
#                heartbeat_destination_type: 2,
#                heartbeat_destination_address: 'MyText'
#              ),
#              HeartbeatDestination.create!(
#                switch: nil,
#                heartbeat_destination_type: 2,
#                heartbeat_destination_address: 'MyText'
#              )
#            ])
#   end

#   it 'renders a list of heartbeat_destinations' do
#     render
#     assert_select 'tr>td', text: nil.to_s, count: 2
#     assert_select 'tr>td', text: 2.to_s, count: 2
#     assert_select 'tr>td', text: 'MyText'.to_s, count: 2
#   end
# end
