# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_tests
#
#  id                     :bigint           not null, primary key
#  dialogic_learn_obj_id  :bigint           not null
#  overall_assmnt_item_id :bigint           not null
#  overall_points         :float
#  user_id                :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class DialogicTest < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_learn_obj
  belongs_to :user
  belongs_to :overall_assmnt_item, optional: true
  has_many :dialogic_test_answers, dependent: :destroy

  # Methods ...
  def all_answers_records_for(qstn_id)
    dialogic_test_answers.where(dialogic_question_id: qstn_id)
  end

  def learner_attempt_of(question_id)
    last_attempt = dialogic_test_answers.where(dialogic_question_id: question_id)
                    &.pluck(:attempt)&.max || 0
    last_attempt + 1
  end
end
