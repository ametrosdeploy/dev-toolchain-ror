# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formula_nlu_concepts
#
#  id             :bigint           not null, primary key
#  nlu_concept_id :bigint           not null
#  qa_formula_id  :bigint           not null
#  present_cond   :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class QaFormulaNluConcept < ApplicationRecord
  belongs_to :nlu_concept
  belongs_to :qa_formula
end
