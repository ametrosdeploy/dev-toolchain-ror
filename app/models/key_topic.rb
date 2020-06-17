# frozen_string_literal: true

# == Schema Information
#
# Table name: key_topics
#
#  id                   :bigint           not null, primary key
#  dialogic_question_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class KeyTopic < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_question
  has_many :key_topic_values, dependent: :destroy
  has_many :dialogic_assmnt_items, dependent: :destroy
end
