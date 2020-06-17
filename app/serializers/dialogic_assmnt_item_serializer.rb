# frozen_string_literal: true

class DialogicAssmntItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :key_topic_id, :assessment_label_id, :value_count_min,
             :value_count_max, :points, :have_follow_up_question

  attribute :follow_up_question do |item|
    FollowUpQuestionSerializer.new(item.follow_up_question).as_json['data']
  end

  attribute :required_key_topic_values do |item|
    RequiredKeyTopicValueSerializer.new(item.required_key_topic_values).as_json['data']
  end
end
