# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint           not null
#  overall_assmnt_item_id :bigint
#  overall_points         :float
#  repeat_count           :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  complete               :boolean          default(FALSE)
#
class DialogicEvaluation < ApplicationRecord
  belongs_to :user_learn_obj
  belongs_to :overall_assmnt_item, optional: true
  has_many :dialogic_answers, dependent: :destroy
  has_many :dialogic_debrief_evaluations, dependent: :destroy

  # Call this to complete a dialogic
  def complete_dialogic
    update(complete: true)
  end
end
