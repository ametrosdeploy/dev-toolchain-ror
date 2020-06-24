# frozen_string_literal: true

module Learner
  # Learner Quiz Evaluation serializer
  class QuizEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :quiz_complete, :points, :point_type,
               :overall_message, :tally_message

    attribute :quiz_responses do |evaluation|
      Learner::QuizResponseSerializer.new(evaluation.quiz_responses)
                                     .as_json['data']
    end

    attribute :overall_assmnt_item do |evaluation|
      Learner::OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
                                          .as_json['data']
    end
  end
end
