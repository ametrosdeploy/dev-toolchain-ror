# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_asst_entity_values
#
#  id                   :bigint           not null, primary key
#  asst_entity_value_id :bigint           not null
#  response_formula_id  :bigint           not null
#  present_cond         :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class FormulaAsstEntityValue < ApplicationRecord
  # Associations ...
  belongs_to :asst_entity_value
  belongs_to :response_formula
end
