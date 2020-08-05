# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formula_sentiments
#
#  id            :bigint           not null, primary key
#  sentiment     :integer
#  comparator    :integer
#  score         :float
#  qa_formula_id :bigint           not null
#  present_cond  :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  range_value   :float
#
class QaFormulaSentiment < ApplicationRecord
  # Associations ...
  belongs_to :qa_formula

  # Enum ...
  enum sentiment: %i[positive negative]
  enum comparator: %i[lt gt range]

  # Scopes ...
  scope :to_be_present, -> { where(present_cond: true) }
  scope :to_be_absent, -> { where(present_cond: false) }
end
