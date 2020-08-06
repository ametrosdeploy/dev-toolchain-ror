# == Schema Information
#
# Table name: assessment_formula_nlu_concepts
#
#  id                    :bigint           not null, primary key
#  nlu_concept_id        :bigint
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class AssessmentFormulaNluConcept < ApplicationRecord
  # Associations ...
  belongs_to :nlu_concept
  belongs_to :assessment_formula
end
