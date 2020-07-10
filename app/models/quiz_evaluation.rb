# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint           not null
#  quiz_submitted         :boolean          default(FALSE)
#  evaluated              :boolean          default(FALSE)
#  point_type             :integer
#  points                 :float
#  overall_assmnt_item_id :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  quiz_complete          :boolean          default(FALSE)
#
class QuizEvaluation < ApplicationRecord
  enum point_type: %i[numeric percentage tally_correct_ans]

  # Associations ...
  belongs_to :user_learn_obj
  belongs_to :overall_assmnt_item, optional: true
  has_many :quiz_responses, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :quiz_responses

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
end
