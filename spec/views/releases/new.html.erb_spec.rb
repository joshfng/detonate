# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/new', type: :view do
  before do
    assign(:release, Release.new(
                       switch_id: 'MyText',
                       release_type: 1,
                       release_address_ciphertext: 'MyText',
                       release_sent: false
                     ))
  end

  it 'renders new release form' do
    render

    assert_select 'form[action=?][method=?]', releases_path, 'post' do
      assert_select 'textarea[name=?]', 'release[switch_id]'

      assert_select 'input[name=?]', 'release[release_type]'

      assert_select 'textarea[name=?]', 'release[release_address_ciphertext]'

      assert_select 'input[name=?]', 'release[release_sent]'
    end
  end
end
