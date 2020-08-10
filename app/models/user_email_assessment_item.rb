# == Schema Information
#
# Table name: user_email_assessment_items
#
#  id                       :bigint           not null, primary key
#  email_assessment_item_id :bigint
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  debrief_id               :bigint
#  debrief_content          :text
#  debrief_variant          :integer
#  user_email_evaluation_id :bigint
#
class UserEmailAssessmentItem < ApplicationRecord
  belongs_to  :email_assessment_item 
  belongs_to  :user_email_evaluation
end
