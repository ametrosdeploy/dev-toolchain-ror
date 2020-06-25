# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_assmnt_items
#
#  id                      :bigint           not null, primary key
#  key_topic_id            :bigint           not null
#  assessment_label_id     :bigint           not null
#  value_count_min         :integer
#  value_count_max         :integer
#  points                  :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  have_follow_up_question :boolean          default(FALSE)
#
class DialogicAssmntItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :key_topic_id, :assessment_label_id, :value_count_min,
             :value_count_max, :points, :have_follow_up_question

  attribute :follow_up_question do |item|
    FollowUpQuestionSerializer.new(item.follow_up_question).as_json['data']
  end

  attribute :required_key_topic_values do |item|
    RequiredKeyTopicValueSerializer.new(item.required_key_topic_values)
                                   .as_json['data']
  end

  attribute :responses do |item|
    DialogicResponseSerializer.new(item.dialogic_responses)
                              .as_json['data']
  end
end
