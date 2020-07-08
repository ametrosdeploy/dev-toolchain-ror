# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_asst_entity_values
#
#  id                   :bigint           not null, primary key
#  asst_entity_value_id :bigint           not null
#  response_formula_id  :bigint           not null
#  present_cond         :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class FormulaAsstEntityValueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :present_cond

  attribute :asst_intent do |formula|
    formula.asst_entity_value.value
  end
end
