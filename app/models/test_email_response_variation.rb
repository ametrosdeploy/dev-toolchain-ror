# frozen_string_literal: true

class TestEmailResponseVariation < ApplicationRecord
  # Associations ...
  belongs_to :test_email_iteration
  belongs_to :char_response_variation
end
