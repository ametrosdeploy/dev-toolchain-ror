# frozen_string_literal: true

# == Schema Information
#
# Table name: test_email_response_variations
#
#  id                         :bigint           not null, primary key
#  test_email_iteration_id    :bigint           not null
#  char_response_variation_id :bigint           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class TestEmailResponseVariation < ApplicationRecord
  # Associations ...
  belongs_to :test_email_iteration
  belongs_to :char_response_variation
end
