# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_learn_objs
#
#  id                                  :bigint           not null, primary key
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  title                               :string
#  description                         :text
#  score_view_type                     :integer          default("numeric")
#  overall_assessment_required         :boolean          default(FALSE)
#  overall_module_assessment_inclusion :boolean          default(FALSE)
#
class QuizLearnObj < ApplicationRecord
  enum score_view_type: %i[numeric percentage tally_correct_ans]

  # Associations ...
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
  has_many :quiz_questions

  def watson_asst_dialog_skill
    assistant_dialog_skill.skill_id
  end
end
