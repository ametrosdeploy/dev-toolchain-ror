# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint
#  quiz_submitted         :boolean          default(FALSE)
#  evaluated              :boolean          default(FALSE)
#  point_type             :integer
#  points                 :float
#  overall_assmnt_item_id :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  quiz_complete          :boolean          default(FALSE)
#  question_order_ids     :integer          default([]), is an Array
#  learning_object_id     :bigint
#
class QuizEvaluation < ApplicationRecord
  enum point_type: %i[numeric percentage tally_correct_ans]

  # Associations ...
  belongs_to :user_learn_obj, optional: true
  belongs_to :overall_assmnt_item, optional: true
  has_many :quiz_responses, dependent: :destroy

  # This association is only for evaluation quizes
  belongs_to :learning_object, optional: true

  # Nested attributes ...
  accepts_nested_attributes_for :quiz_responses

  scope :test_data, -> { where(user_learn_obj_id: nil) }

  # Make sure user_learn_obj_id is present if not test data
  validates :user_learn_obj_id, presence: {unless: :learning_object_id?}

  def overall_message
    case point_type
    when 'numeric'
      "You have scored #{points.to_i} points out of #{total_points}"
    when 'percentage'
      "You have scored #{points}%"
    else
      tally_message
    end
  end

  def tally_message
    "#{correct_response_count}/#{quiz_responses.length} answers are correct!"
  end

  def total_points
    quiz_responses.joins(:quiz_question).sum(:points)
  end

  def correct_response_count
    quiz_responses.count(&:is_correct)
  end

  # Gives Quiz in Random order & Also preserves the order
  def question_orders(quiz_learn_obj_id)
    if question_order_ids?
      question_order_ids
    else
      questions_ids = QuizQuestion.where(quiz_learn_obj_id: quiz_learn_obj_id)
                                  .pluck(:id).try(:shuffle)
      update(question_order_ids: questions_ids)
      questions_ids
    end
  end

  # Clears previous test record
  def self.clear_test_record
    test_data.where("created_at < ?", (Time.now - 1.day)).destroy_all
  end
end
