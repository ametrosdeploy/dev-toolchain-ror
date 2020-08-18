# == Schema Information
#
# Table name: test_email_qa_condition_hits
#
#  id                      :bigint           not null, primary key
#  test_email_iteration_id :bigint           not null
#  qa_condition_id         :bigint           not null
#  qa_formula_hits         :integer          default([]), is an Array
#  blank_response_hit      :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class TestEmailQaConditionHit < ApplicationRecord
  belongs_to :test_email_iteration
  belongs_to :qa_condition
end
