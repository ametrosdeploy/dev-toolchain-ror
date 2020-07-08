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
class FormulaNluConcept < ApplicationRecord
  # Associations ...
  belongs_to :nlu_concept
  belongs_to :response_formula
end
