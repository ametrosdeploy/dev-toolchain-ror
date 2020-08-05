# == Schema Information
#
# Table name: test_email_response_formula_hits
#
#  id                       :bigint           not null, primary key
#  test_email_evaluation_id :bigint           not null
#  response_formula_id      :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class TestEmailResponseFormulaHit < ApplicationRecord
  belongs_to :test_email_evaluation
  belongs_to :response_formula
end
