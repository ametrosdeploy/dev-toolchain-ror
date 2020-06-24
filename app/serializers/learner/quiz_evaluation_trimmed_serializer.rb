# frozen_string_literal: true

module Learner
  # Less info of Quiz Evaluation
  class QuizEvaluationTrimmedSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :quiz_complete

    attribute :quiz_responses do |evaluation|
      Learner::QuizResponseTrimmedSerializer.new(evaluation.quiz_responses)
                                            .as_json['data']
    end

    # attribute :overall_assmnt_item do |evaluation|
    #   OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
    #                              .as_json['data']
    # end
  end
end
