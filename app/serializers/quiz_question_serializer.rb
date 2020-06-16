# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_questions
#
#  id                   :bigint           not null, primary key
#  question             :text
#  question_type        :integer
#  points               :integer
#  order                :integer
#  feedback_from_watson :boolean          default(FALSE)
#  quiz_learn_obj_id    :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class QuizQuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :question, :question_type, :points,
             :feedback_from_watson, :quiz_learn_obj_id

  attribute :mcq_options, if: proc { |record|
    record.mcq_options.present?
  } do |question|
    McqOptionSerializer.new(question.mcq_options).as_json['data']
  end

  attribute :numeric_answer, if: proc { |record|
    record.numeric_answer.present?
  } do |question|
    NumericAnswerSerializer.new(question.numeric_answer).as_json['data']
  end

  attribute :range_answer, if: proc { |record|
    record.range_answer.present?
  } do |question|
    RangeAnswerSerializer.new(question.range_answer).as_json['data']
  end

  attribute :quiz_feedback do |question|
    QuizFeedbackSerializer.new(question.quiz_feedback).as_json['data']
  end
end
