# frozen_string_literal: true

# == Schema Information
#
# Table name: response_formula_items
#
#  id                   :bigint           not null, primary key
#  response_formula_id  :bigint           not null
#  enrichment_item_type :string           not null
#  enrichment_item_id   :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  present              :boolean          default(TRUE)
#
class ResponseFormulaItem < ApplicationRecord
  # Associations ...
  belongs_to :response_formula
  belongs_to :enrichment_item, polymorphic: true
end
