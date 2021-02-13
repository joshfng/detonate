# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'checkins/show', type: :view do
  before do
    @checkin = assign(:checkin, Checkin.create!(
                                  switch: nil,
                                  checkin_type: 2,
                                  checkin_address: 'MyText'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
