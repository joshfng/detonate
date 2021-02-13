# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserCheckins', type: :request do
  describe 'GET /checkin' do
    it 'returns http success' do
      get '/user_checkins/checkin'
      expect(response).to have_http_status(:success)
    end
  end
end
