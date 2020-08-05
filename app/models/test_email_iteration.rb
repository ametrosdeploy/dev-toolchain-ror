# == Schema Information
#
# Table name: test_email_iterations
#
#  id                       :bigint           not null, primary key
#  email                    :text
#  iteration                :integer
#  test_email_evaluation_id :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class TestEmailIteration < ApplicationRecord
  belongs_to :test_email_evaluation
  has_many :user_response_variations, 
           class_name: 'TestEmailResponseVariation', dependent: :destroy
    has_many :user_email_iteration_responses,
             class_name: 'TestEmailIterationResponse', dependent: :destroy
end
