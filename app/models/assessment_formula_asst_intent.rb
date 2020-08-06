# == Schema Information
#
# Table name: assessment_formula_asst_intents
#
#  id                    :bigint           not null, primary key
#  asst_intent_id        :bigint
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class AssessmentFormulaAsstIntent < ApplicationRecord
  # Associations ...
  belongs_to :asst_intent
  belongs_to :assessment_formula
end
