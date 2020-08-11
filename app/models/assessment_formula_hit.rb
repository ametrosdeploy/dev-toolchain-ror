# == Schema Information
#
# Table name: assessment_formula_hits
#
#  id                       :bigint           not null, primary key
#  user_email_evaluation_id :bigint
#  assessment_formula_id    :bigint
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class AssessmentFormulaHit < ApplicationRecord
  # Associations ...
  belongs_to :user_email_evaluation
  belongs_to :assessment_formula
end
