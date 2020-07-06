# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::EmailLearnObjController, type: :controller do
  describe 'GET #analyse_ideal_email' do
    it 'returns http success' do
      get :analyse_ideal_email
      expect(response).to have_http_status(:success)
    end
  end
end
