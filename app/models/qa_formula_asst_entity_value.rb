# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formula_asst_entity_values
#
#  id                   :bigint           not null, primary key
#  asst_entity_value_id :bigint           not null
#  qa_formula_id        :bigint           not null
#  present_cond         :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class QaFormulaAsstEntityValue < ApplicationRecord
  belongs_to :asst_entity_value
  belongs_to :qa_formula
end
