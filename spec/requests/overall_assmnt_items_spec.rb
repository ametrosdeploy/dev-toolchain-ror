# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OverallAssmntItems', type: :request do
  describe 'GET /overall_assmnt_items' do
    it 'works! (now write some real specs)' do
      get overall_assmnt_items_path
      expect(response).to have_http_status(200)
    end
  end
end
