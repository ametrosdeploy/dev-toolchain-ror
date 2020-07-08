# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_asst_intents
#
#  id                  :bigint           not null, primary key
#  asst_intent_id      :bigint           not null
#  response_formula_id :bigint           not null
#  present_cond        :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class FormulaAsstIntent < ApplicationRecord
  # Associations ...
  belongs_to :asst_intent
  belongs_to :response_formula
end
