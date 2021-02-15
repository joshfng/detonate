# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'heartbeat_destinations/new', type: :view do
#   before do
#     assign(:heartbeat_destination, HeartbeatDestination.new(
#                                      switch: nil,
#                                      heartbeat_destination_type: 1,
#                                      heartbeat_destination_address: 'MyText'
#                                    ))
#   end

#   it 'renders new heartbeat_destination form' do
#     render

#     assert_select 'form[action=?][method=?]', heartbeat_destinations_path, 'post' do
#       assert_select 'input[name=?]', 'heartbeat_destination[switch_id]'

#       assert_select 'input[name=?]', 'heartbeat_destination[heartbeat_destination_type]'

#       assert_select 'textarea[name=?]', 'heartbeat_destination[heartbeat_destination_address]'
#     end
#   end
# end
