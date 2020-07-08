# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_nlu_entities
#
#  id                  :bigint           not null, primary key
#  nlu_entity_id       :bigint           not null
#  response_formula_id :bigint           not null
#  present_cond        :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class FormulaNluEntitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :present_cond

  attribute :nlu_entity do |formula|
    formula.nlu_entity.entity
  end
end
