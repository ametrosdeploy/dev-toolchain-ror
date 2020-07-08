# frozen_string_literal: true

# == Schema Information
#
# Table name: email_responses
#
#  id                 :bigint           not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email_learn_obj_id :bigint           not null
#
class EmailResponse < ApplicationRecord
  # Associations ...
  has_many :char_response_variations
  has_many :response_formulas

  # Nested attributes ...
  accepts_nested_attributes_for :char_response_variations, allow_destroy: true
  accepts_nested_attributes_for :response_formulas, allow_destroy: true
end
