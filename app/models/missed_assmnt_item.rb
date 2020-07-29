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
  has_many :follow_up_questions, as: :follow_up_able, dependent: :destroy
  has_many :debriefs, as: :debriefable
  has_many :adaptive_contents, as: :adaptable, dependent: :destroy

  # Nested Attributes ...
  accepts_nested_attributes_for :missed_responses, allow_destroy: true
  accepts_nested_attributes_for :follow_up_questions, allow_destroy: true
  accepts_nested_attributes_for :debriefs, allow_destroy: true

  # Methods
  def charcter_responses
    # missed_responses.where(follow_up: false)
  end

  def follow_up_responses
    # missed_responses.where(follow_up: true)
  end
end
