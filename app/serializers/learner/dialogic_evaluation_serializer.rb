# frozen_string_literal: true

module Learner
  # Learner dialogic evaluations
  class DialogicEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :repeat_count, :complete

    attribute :overall_assmnt_item do |evaluation|
      Learner::OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
                                          .as_json['data']
    end

    attribute :dialogic_debrief_evaluation do |evaluation|
      debrief = evaluation.dialogic_debrief_evaluations
      Learner::DialogicDebriefEvaluationSerializer.new(debrief).as_json['data']
    end
  end
end
