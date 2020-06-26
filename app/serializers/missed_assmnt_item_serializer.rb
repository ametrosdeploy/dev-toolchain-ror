# frozen_string_literal: true

class MissedAssmntItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :key_topic_id, :has_follow_up_question

  attribute :character_responses do |item|
    MissedResponseSerializer.new(item.charcter_responses)
                            .as_json['data']
  end

  attribute :follow_up_question do |item|
    FollowUpQuestionSerializer.new(item.follow_up_question).as_json['data']
  end

  attribute :follow_up_responses do |item|
    MissedResponseSerializer.new(item.follow_up_responses)
                            .as_json['data']
  end
end
