# frozen_string_literal: true

# == Schema Information
#
# Table name: answer_key_topic_evaluations
#
#  id                      :bigint           not null, primary key
#  dialogic_answer_id      :bigint           not null
#  key_topic_id            :bigint           not null
#  dialogic_assmnt_item_id :bigint
#  missed_assmnt_item_id   :bigint
#  points_earned           :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  iteration_delivered     :integer
#
class AnswerKeyTopicEvaluation < ApplicationRecord
  belongs_to :dialogic_answer
  belongs_to :key_topic
  belongs_to :dialogic_assmnt_item, optional: true
  belongs_to :missed_assmnt_item, optional: true

  # Methods
  def missed?
    missed_assmnt_item_id.present?
  end

  def assessment
    missed? ? missed_assmnt_item : dialogic_assmnt_item
  end
end
