# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_emotions
#
#  id                  :bigint           not null, primary key
#  emotion             :integer
#  comparator          :integer
#  score               :float
#  present_cond        :boolean
#  response_formula_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  range_value         :float
#
class FormulaEmotion < ApplicationRecord
  # Associations ...
  belongs_to :response_formula

  # Enum ...
  enum emotion: %i[sadness joy fear disgust anger]
  enum comparator: %i[lt gt range]

  # Scopes ...
  scope :to_be_present, -> { where(present_cond: true) }
  scope :to_be_absent, -> { where(present_cond: false) }
end
