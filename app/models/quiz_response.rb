# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_responses
#
#  id                :bigint           not null, primary key
#  response          :text
#  mcq_response_id   :integer
#  evaluated         :boolean          default(FALSE)
#  is_correct        :boolean
#  points_earned     :float
#  feedback_received :text
#  user_learn_obj_id :bigint           not null
#  quiz_question_id  :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class QuizResponse < ApplicationRecord
  # Associations ...
  belongs_to :user_learn_obj
  belongs_to :quiz_question
  belongs_to :mcq_response,
             class_name: 'McqOption', optional: true

  # Validations ...
  validates_uniqueness_of :user_learn_obj_id, scope: %i[quiz_question_id]

  after_save :update_overall_interaction_assesment

  def update_overall_interaction_assesment; end
end
