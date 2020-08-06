# == Schema Information
#
# Table name: assessment_formula_nlu_entities
#
#  id                    :bigint           not null, primary key
#  nlu_entity_id         :bigint
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class AssessmentFormulaNluEntity < ApplicationRecord
  # Association ...
  belongs_to :nlu_entity
  belongs_to :assessment_formula
end
