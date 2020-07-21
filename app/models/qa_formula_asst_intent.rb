# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formula_asst_intents
#
#  id             :bigint           not null, primary key
#  asst_intent_id :bigint           not null
#  qa_formula_id  :bigint           not null
#  present_cond   :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class QaFormulaAsstIntent < ApplicationRecord
  belongs_to :asst_intent
  belongs_to :qa_formula
end
