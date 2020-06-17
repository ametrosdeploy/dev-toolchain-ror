# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_questions
#
#  id                    :bigint           not null, primary key
#  concept               :string
#  question              :text
#  order                 :integer
#  dialogic_learn_obj_id :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class DialogicQuestion < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_learn_obj
  has_many :question_variations
  has_many :key_topics

  # validations...
  validates_uniqueness_of :order, scope: :dialogic_learn_obj_id, on: :create

  # Nested attributes ...
  accepts_nested_attributes_for :question_variations, allow_destroy: true
end
