# frozen_string_literal: true

# == Schema Information
#
# Table name: response_formulas
#
#  id                       :bigint           not null, primary key
#  formula                  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  email_response_id        :bigint           not null
#  present_cond_keyword_min :integer
#  absent_cond_keyword_min  :integer
#
class ResponseFormula < ApplicationRecord
  # Associations ...
  has_many :response_formula_items

  # Nested attributes ...
  accepts_nested_attributes_for :response_formula_items, allow_destroy: true
end
