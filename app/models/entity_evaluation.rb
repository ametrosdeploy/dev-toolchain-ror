# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_evaluations
#
#  id               :bigint           not null, primary key
#  condition        :text
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class EntityEvaluation < ApplicationRecord
  # Associations ...
  belongs_to :quiz_question
  has_many :entity_evaluation_items, dependent: :destroy
  has_many :asst_entity_values, through: :entity_evaluation_items

  # Nested attributes ...
  accepts_nested_attributes_for :entity_evaluation_items, allow_destroy: true
end
