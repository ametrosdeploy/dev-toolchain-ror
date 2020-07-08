# frozen_string_literal: true

# == Schema Information
#
# Table name: response_formulas
#
#  id                       :bigint           not null, primary key
#  formula                  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  email_response_id        :bigint           not null
#  present_cond_keyword_min :integer
#  absent_cond_keyword_min  :integer
#
class ResponseFormula < ApplicationRecord
  # Associations ...
  has_many :formula_nlu_entities, dependent: :destroy
  has_many :nlu_entities, through: :formula_nlu_entities

  has_many :formula_nlu_keywords, dependent: :destroy
  has_many :nlu_keywords, through: :formula_nlu_keywords

  has_many :formula_nlu_concepts, dependent: :destroy
  has_many :nlu_concepts, through: :formula_nlu_concepts

  has_many :formula_asst_intents, dependent: :destroy
  has_many :asst_intents, through: :formula_asst_intents

  has_many :formula_asst_entity_values, dependent: :destroy
  has_many :asst_entity_values, through: :formula_asst_entity_values

  has_many :formula_emotions, dependent: :destroy
  has_many :formula_sentiments, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :formula_nlu_entities, allow_destroy: true
  accepts_nested_attributes_for :formula_nlu_keywords, allow_destroy: true
  accepts_nested_attributes_for :formula_nlu_concepts, allow_destroy: true
  accepts_nested_attributes_for :formula_asst_intents, allow_destroy: true
  accepts_nested_attributes_for :formula_asst_entity_values, allow_destroy: true
  accepts_nested_attributes_for :formula_emotions, allow_destroy: true
  accepts_nested_attributes_for :formula_sentiments, allow_destroy: true
end
