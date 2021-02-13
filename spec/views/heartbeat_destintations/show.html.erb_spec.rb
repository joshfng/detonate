# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'heartbeat_destinations/show', type: :view do
  before do
    @heartbeat_destination = assign(:heartbeat_destination, HeartbeatDestination.create!(
                                                              switch: nil,
                                                              heartbeat_destination_type: 2,
                                                              heartbeat_destination_address: 'MyText'
                                                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
