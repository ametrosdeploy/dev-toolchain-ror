# frozen_string_literal: true

# == Schema Information
#
# Table name: required_key_topic_values
#
#  id                      :bigint           not null, primary key
#  dialogic_assmnt_item_id :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  key_topic_value_id      :integer
#
class RequiredKeyTopicValue < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_assmnt_item
  belongs_to :key_topic_value, class_name: 'AsstEntityValue'
end
