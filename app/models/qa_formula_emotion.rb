# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formula_emotions
#
#  id            :bigint           not null, primary key
#  emotion       :integer
#  comparator    :integer
#  score         :float
#  qa_formula_id :bigint           not null
#  present_cond  :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class QaFormulaEmotion < ApplicationRecord
  # Associations ...
  belongs_to :qa_formula

  # Enum ...
  enum emotion: %i[sadness joy fear disgust anger]
  enum comparator: %i[lt gt lt_eq gt_eq]

  # Scopes ...
  scope :to_be_present, -> { where(present_cond: true) }
  scope :to_be_absent, -> { where(present_cond: false) }
end
