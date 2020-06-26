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
class MissedAssmntItem < ApplicationRecord
  # Associations ...
  belongs_to :key_topic
  has_many :missed_responses, dependent: :destroy
  has_one :follow_up_question, as: :follow_up_able, dependent: :destroy

  # Nested Attributes ...
  accepts_nested_attributes_for :missed_responses, allow_destroy: true
  accepts_nested_attributes_for :follow_up_question, allow_destroy: true

  # Methods
  def charcter_responses
    missed_responses.where(follow_up: false)
  end

  def follow_up_responses
    missed_responses.where(follow_up: true)
  end
end
