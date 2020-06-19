# frozen_string_literal: true

module Learner
  # Learner Quiz questions
  class QuizQuestionSerializer
    include FastJsonapi::ObjectSerializer
    attributes :question, :question_type, :quiz_learn_obj_id

    attribute :mcq_options, if: proc { |record|
      record.mcq_options.present?
    } do |question|
      Learner::McqOptionSerializer.new(question.mcq_options).as_json['data']
    end
  end
end
