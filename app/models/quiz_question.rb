# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_questions
#
#  id                   :bigint           not null, primary key
#  question             :text
#  question_type        :integer
#  points               :integer
#  order                :integer
#  feedback_from_watson :boolean          default(FALSE)
#  quiz_learn_obj_id    :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class QuizQuestion < ApplicationRecord
  # Enums ...
  enum type: %i[multiple_choice numeric range long_answer]
  # Associations ...
  belongs_to :quiz_learn_obj
  has_many :mcq_options, dependent: :destroy
  has_one :quiz_feedback, dependent: :destroy

  # Validations ...
  validates :question, :question_type, :quiz_learn_obj_id, presence: true

  # Nested attributes ...
  accepts_nested_attributes_for :mcq_options, allow_destroy: true
  accepts_nested_attributes_for :quiz_feedback, allow_destroy: true
end
