# frozen_string_literal: true

module Learner
  class AnswerKeyTopicEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :dialogic_answer_id, :key_topic_id,
               :dialogic_assmnt_item_id, :missed_assmnt_item_id, :points_earned

    attribute :dialogic_assmnt_item, if: proc { |record|
                                           record.dialogic_assmnt_item_id?
                                         } do |eval|
      DialogicAssmntItemSerializer.new(eval.dialogic_assmnt_item)
                                  .as_json['data']
    end

    attribute :missed_assmnt_item_id, if: proc { |record|
                                            record.missed_assmnt_item_id?
                                          } do |eval|
      MissedAssmntItemSerializer.new(eval.missed_assmnt_item).as_json['data']
    end
  end
end
