# frozen_string_literal: true

# == Schema Information
#
# Table name: key_topic_values
#
#  id           :bigint           not null, primary key
#  key_topic_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class KeyTopicValue < ApplicationRecord
  # Associations ...
  belongs_to :key_topic
end
