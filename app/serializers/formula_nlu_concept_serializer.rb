# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_nlu_concepts
#
#  id                  :bigint           not null, primary key
#  nlu_concept_id      :bigint           not null
#  response_formula_id :bigint           not null
#  present_cond        :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class FormulaNluConceptSerializer
  include FastJsonapi::ObjectSerializer
  attributes :present_cond

  attribute :nlu_concept do |formula|
    formula.nlu_concept.concept
  end
end
