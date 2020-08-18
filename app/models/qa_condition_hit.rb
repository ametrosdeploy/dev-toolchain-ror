# == Schema Information
#
# Table name: qa_condition_hits
#
#  id                      :bigint           not null, primary key
#  user_email_iteration_id :bigint           not null
#  qa_condition_id         :bigint           not null
#  qa_formula_hits         :integer          default([]), is an Array
#  blank_response_hit      :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class QaConditionHit < ApplicationRecord
  belongs_to :user_email_iteration
  belongs_to :qa_condition
end
