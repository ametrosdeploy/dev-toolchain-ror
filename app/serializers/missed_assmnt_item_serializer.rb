# frozen_string_literal: true

# == Schema Information
#
# Table name: missed_assmnt_items
#
#  id                     :bigint           not null, primary key
#  key_topic_id           :bigint           not null
#  has_follow_up_question :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
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

  attribute :debrief_contents do |item|
    DebriefSerializer.new(item.debriefs).as_json['data']
  end

  attribute :adaptive_contents do |item|
    AdaptiveContentSerializer.new(item.adaptive_contents).as_json['data']
  end
end
