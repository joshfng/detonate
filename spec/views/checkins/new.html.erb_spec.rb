# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'checkins/new', type: :view do
  before do
    assign(:checkin, Checkin.new(
                       switch: nil,
                       checkin_type: 1,
                       checkin_address: 'MyText'
                     ))
  end

  it 'renders new checkin form' do
    render

    assert_select 'form[action=?][method=?]', checkins_path, 'post' do
      assert_select 'input[name=?]', 'checkin[switch_id]'

      assert_select 'input[name=?]', 'checkin[checkin_type]'

      assert_select 'textarea[name=?]', 'checkin[checkin_address]'
    end
  end
end
