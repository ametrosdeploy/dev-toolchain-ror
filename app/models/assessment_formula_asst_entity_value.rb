# == Schema Information
#
# Table name: assessment_formula_asst_entity_values
#
#  id                    :bigint           not null, primary key
#  asst_entity_value_id  :bigint
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class AssessmentFormulaAsstEntityValue < ApplicationRecord
  # Associations ...
  belongs_to :asst_entity_value
  belongs_to :assessment_formula
end
