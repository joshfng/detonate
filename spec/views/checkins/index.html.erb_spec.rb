# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'checkins/index', type: :view do
  before do
    assign(:checkins, [
             Checkin.create!(
               switch: nil,
               checkin_type: 2,
               checkin_address: 'MyText'
             ),
             Checkin.create!(
               switch: nil,
               checkin_type: 2,
               checkin_address: 'MyText'
             )
           ])
  end

  it 'renders a list of checkins' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
