# == Schema Information
#
# Table name: assessment_formula_nlu_keywords
#
#  id                    :bigint           not null, primary key
#  nlu_keyword_id        :bigint
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class AssessmentFormulaNluKeyword < ApplicationRecord
  # Associations ...
  belongs_to :nlu_keyword
  belongs_to :assessment_formula
end
