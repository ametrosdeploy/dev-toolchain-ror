# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Admin::V1::DialogicLearnObjsController, type: :controller do
  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #reorder_questions' do
    it 'returns http success' do
      get :reorder_questions
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #add_introduction' do
    it 'returns http success' do
      get :add_introduction
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #add_conclusion' do
    it 'returns http success' do
      get :add_conclusion
      expect(response).to have_http_status(:success)
    end
  end
end
