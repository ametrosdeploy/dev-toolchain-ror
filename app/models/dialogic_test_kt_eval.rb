# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_test_kt_evals
#
#  id                      :bigint           not null, primary key
#  dialogic_test_answer_id :bigint           not null
#  key_topic_id            :bigint           not null
#  dialogic_assmnt_item_id :bigint
#  missed_assmnt_item_id   :bigint
#  points_earned           :float
#  iteration_delivered     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class DialogicTestKtEval < ApplicationRecord
  belongs_to :dialogic_test_answer
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
