# frozen_string_literal: true

module Learner
  # Learner quiz question
  class QuizQuestionWithAnswerSerializer
    include FastJsonapi::ObjectSerializer
    attributes :question, :question_type, :points, :quiz_learn_obj_id

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
end
