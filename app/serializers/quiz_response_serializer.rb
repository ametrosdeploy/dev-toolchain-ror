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
#
class QuizResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :evaluated, :is_correct, :points_earned, :feedback_received,
             :quiz_question_id

  attribute :question do |res|
    QuizQuestionSerializer.new(res.quiz_question).as_json['data']
  end

  attribute :learner_answer, if: proc { |record|
    record.mcq_response_id.blank?
  }, &:response
  attribute :learner_chosed_option, if: proc { |record|
    record.mcq_response_id.present?
  } do |res|
    McqOptionSerializer.new(res.mcq_response).as_json['data']
  end
end
