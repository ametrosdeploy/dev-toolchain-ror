# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_responses
#
#  id                 :bigint           not null, primary key
#  response           :text
#  mcq_response_id    :integer
#  evaluated          :boolean          default(FALSE)
#  is_correct         :boolean
#  points_earned      :float
#  feedback_received  :text
#  quiz_question_id   :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  quiz_evaluation_id :bigint           not null
#  watson_response    :text
#
class QuizResponse < ApplicationRecord
  # Associations ...
  belongs_to :quiz_question
  belongs_to :mcq_response,
             class_name: 'McqOption', optional: true
  belongs_to :quiz_evaluation

  # Validations ...
  validates_uniqueness_of :quiz_evaluation_id, scope: %i[quiz_question_id]
end
