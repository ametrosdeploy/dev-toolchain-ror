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
class FormulaAsstIntentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :present_cond

  attribute :asst_intent do |formula|
    formula.asst_intent.name
  end
end
