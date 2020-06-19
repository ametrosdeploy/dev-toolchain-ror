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
#
class QuizEvaluation < ApplicationRecord
  enum point_type: %i[numeric percentage tally_correct_ans]

  # Associations ...
  belongs_to :user_learn_obj
  belongs_to :overall_assmnt_item, optional: true
  has_many :quiz_responses, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :quiz_responses
end
