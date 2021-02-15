# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'heartbeat_destinations/edit', type: :view do
#   before do
#     let(:heartbeat_destination) do
#       assign(:heartbeat_destination, HeartbeatDestination.create!(
#                                        switch: nil,
#                                        heartbeat_destination_type: 1,
#                                        heartbeat_destination_address: 'MyText'
#                                      ))
#     end
#   end

#   it 'renders the edit heartbeat_destination form' do
#     render

#     assert_select 'form[action=?][method=?]', heartbeat_destination_path(heartbeat_destination), 'post' do
#       assert_select 'input[name=?]', 'heartbeat_destination[switch_id]'

#       assert_select 'input[name=?]', 'heartbeat_destination[heartbeat_destination_type]'

#       assert_select 'textarea[name=?]', 'heartbeat_destination[heartbeat_destination_address]'
#     end
#   end
# end
