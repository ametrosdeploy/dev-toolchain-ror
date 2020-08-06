# frozen_string_literal: true

module Learner
  # Learner User Chat serializer
  class UserChatSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :character_starts_interaction, :complete,
               :overall_assmnt_item_id, :skills_score_hash, :skills_missed

    # Already sent in ChatLearnObj
    # attribute :chat_character
    # attribute :mentor_character

    attribute :overall_assmnt_item do |evaluation|
      Learner::OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
                                          .as_json['data']
    end

    attribute :chat_debrief_evaluations do |evaluation|
      debrief_eval = evaluation.chat_debrief_evaluations
      Learner::ChatDebriefEvaluationSerializer.new(debrief_eval).as_json['data']
    end
  end
end
