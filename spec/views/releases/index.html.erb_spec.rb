# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'releases/index', type: :view do
#   before do
#     assign(:releases, [
#              Release.create!(
#                switch_id: 'MyText',
#                release_type: 2,
#                release_address_ciphertext: 'MyText',
#                release_sent: false
#              ),
#              Release.create!(
#                switch_id: 'MyText',
#                release_type: 2,
#                release_address_ciphertext: 'MyText',
#                release_sent: false
#              )
#            ])
#   end

#   it 'renders a list of releases' do
#     render
#     assert_select 'tr>td', text: 'MyText'.to_s, count: 2
#     assert_select 'tr>td', text: 2.to_s, count: 2
#     assert_select 'tr>td', text: 'MyText'.to_s, count: 2
#     assert_select 'tr>td', text: false.to_s, count: 2
#   end
# end
