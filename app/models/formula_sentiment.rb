# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_sentiments
#
#  id                  :bigint           not null, primary key
#  sentiment           :integer
#  comparator          :integer
#  score               :float
#  present_cond        :boolean
#  response_formula_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class FormulaSentiment < ApplicationRecord
  # Associations ...
  belongs_to :response_formula

  # Enum ...
  enum sentiment: %i[positive negative]
  enum comparator: %i[lt gt lt_eq gt_eq]

  # Scopes ...
  scope :to_be_present, -> { where(present_cond: true) }
  scope :to_be_absent, -> { where(present_cond: false) }
end
