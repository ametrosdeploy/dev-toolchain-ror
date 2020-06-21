# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::AsstEntityValues', type: :request do
  describe 'GET /asst_entity_values' do
    it 'works! (now write some real specs)' do
      get asst_entity_values_path
      expect(response).to have_http_status(200)
    end
  end
end
