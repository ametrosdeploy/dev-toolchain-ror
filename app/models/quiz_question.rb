# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_questions
#
#  id                   :bigint           not null, primary key
#  question             :text
#  question_type        :integer
#  points               :float
#  order                :integer
#  feedback_from_watson :boolean          default(FALSE)
#  quiz_learn_obj_id    :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  dialog_node_added    :boolean          default(FALSE)
#
class QuizQuestion < ApplicationRecord
  # Enums ...
  enum question_type: %i[multiple_choice numeric range long_answer]

  # Associations ...
  belongs_to :quiz_learn_obj
  has_many :mcq_options, dependent: :destroy
  has_one :quiz_feedback, dependent: :destroy
  has_one :numeric_answer, dependent: :destroy
  has_one :range_answer, dependent: :destroy
  has_many :entity_evaluations, dependent: :destroy
  has_many :quiz_responses, dependent: :destroy

  # Validations ...
  validates :question, :question_type, :points, presence: true
  # validates_uniqueness_of :order, scope: :quiz_learn_obj_id, on: :create

  # Nested attributes ...
  accepts_nested_attributes_for :mcq_options, allow_destroy: true
  accepts_nested_attributes_for :quiz_feedback, allow_destroy: true
  accepts_nested_attributes_for :numeric_answer, allow_destroy: true
  accepts_nested_attributes_for :range_answer, allow_destroy: true

  def correct_option
    mcq_options.where(is_correct: true)
  end
end
