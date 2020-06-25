# frozen_string_literal: true

# == Schema Information
#
# Table name: required_key_topic_values
#
#  id                      :bigint           not null, primary key
#  dialogic_assmnt_item_id :bigint           not null
#  key_topic_value_id      :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class RequiredKeyTopicValueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :key_topic_value_id
end
