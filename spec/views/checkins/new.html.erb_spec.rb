# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'checkins/new', type: :view do
  before do
    assign(:checkin, Checkin.new(
                       switch: nil,
                       checking_type: 1,
                       checkin_address: 'MyText',
                       checkin_confirmed: false
                     ))
  end

  it 'renders new checkin form' do
    render

    assert_select 'form[action=?][method=?]', checkins_path, 'post' do
      assert_select 'input[name=?]', 'checkin[switch_id]'

      assert_select 'input[name=?]', 'checkin[checking_type]'

      assert_select 'textarea[name=?]', 'checkin[checkin_address]'

      assert_select 'input[name=?]', 'checkin[checkin_confirmed]'
    end
  end
end
