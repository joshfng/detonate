# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'checkins/index', type: :view do
  before do
    assign(:checkins, [
             Checkin.create!(
               switch: nil,
               checking_type: 2,
               checkin_address: 'MyText',
               checkin_confirmed: false
             ),
             Checkin.create!(
               switch: nil,
               checking_type: 2,
               checkin_address: 'MyText',
               checkin_confirmed: false
             )
           ])
  end

  it 'renders a list of checkins' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
