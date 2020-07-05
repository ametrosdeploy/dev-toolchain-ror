# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::NluTrainingInputs', type: :request do
  describe 'GET /nlu_training_inputs' do
    it 'works! (now write some real specs)' do
      get nlu_training_inputs_path
      expect(response).to have_http_status(200)
    end
  end
end
