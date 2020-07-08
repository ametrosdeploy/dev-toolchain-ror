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
class FormulaNluEntity < ApplicationRecord
  # Association ...
  belongs_to :nlu_entity
  belongs_to :response_formula
end
