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
                          .group_by(&:dialogic_question_id)
      debrief.map do |key, debrief_eval|
        [ key , Learner::DialogicDebriefEvaluationSerializer.new(debrief_eval)
                                                            .as_json['data'] ]
      end.to_h
    end

    def serialized debriefs
      Learner::DialogicDebriefEvaluationSerializer.new(debriefs)
    end
  end
end
