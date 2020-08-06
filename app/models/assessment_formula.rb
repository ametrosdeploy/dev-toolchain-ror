# == Schema Information
#
# Table name: assessment_formulas
#
#  id                       :bigint           not null, primary key
#  formula                  :string
#  email_assessment_item_id :integer
#  present_cond_keyword_min :integer
#  absent_cond_keyword_min  :integer
#  sentiment_enabled        :boolean          default(TRUE)
#  emotion_enabled          :boolean          default(TRUE)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class AssessmentFormula < ApplicationRecord
  # Associations ...
  belongs_to :email_assessment_item

  has_many :assessment_formula_nlu_entities, dependent: :destroy
  has_many :nlu_entities, through: :assessment_formula_nlu_entities

  has_many :assessment_formula_nlu_keywords, dependent: :destroy
  has_many :nlu_keywords, through: :assessment_formula_nlu_keywords

  has_many :assessment_formula_nlu_concepts, dependent: :destroy
  has_many :nlu_concepts, through: :assessment_formula_nlu_concepts

  has_many :assessment_formula_asst_intents, dependent: :destroy
  has_many :asst_intents, through: :assessment_formula_asst_intents

  has_many :assessment_formula_asst_entity_values, dependent: :destroy
  has_many :asst_entity_values, through: :assessment_formula_asst_entity_values

  has_many :assessment_formula_emotions, dependent: :destroy
  has_many :assessment_formula_sentiments, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :assessment_formula_nlu_entities, allow_destroy: true
  accepts_nested_attributes_for :assessment_formula_nlu_keywords, allow_destroy: true
  accepts_nested_attributes_for :assessment_formula_nlu_concepts, allow_destroy: true
  accepts_nested_attributes_for :assessment_formula_asst_intents, allow_destroy: true
  accepts_nested_attributes_for :assessment_formula_asst_entity_values, allow_destroy: true
  accepts_nested_attributes_for :assessment_formula_emotions, allow_destroy: true
  accepts_nested_attributes_for :assessment_formula_sentiments, allow_destroy: true

  # Methods ...
  def nlu_concepts_to_be_present
    nlu_concepts.where assessment_formula_nlu_concepts: { present_cond: true }
  end

  def nlu_concepts_to_be_absent
    nlu_concepts.where assessment_formula_nlu_concepts: { present_cond: false }
  end

  def nlu_keywords_to_be_present
    nlu_keywords.where assessment_formula_nlu_keywords: { present_cond: true }
  end

  def nlu_keywords_to_be_absent
    nlu_keywords.where assessment_formula_nlu_keywords: { present_cond: false }
  end

  def nlu_entities_to_be_present
    nlu_entities.where assessment_formula_nlu_entities: { present_cond: true }
  end

  def nlu_entities_to_be_absent
    nlu_entities.where assessment_formula_nlu_entities: { present_cond: false }
  end

  def asst_intents_to_be_present
    asst_intents.where assessment_formula_asst_intents: { present_cond: true }
  end

  def asst_intents_to_be_absent
    asst_intents.where assessment_formula_asst_intents: { present_cond: false }
  end

  def asst_entity_values_to_be_present
    asst_entity_values.where assessment_formula_asst_entity_values: { present_cond: true }
  end

  def asst_entity_values_to_be_absent
    asst_entity_values.where assessment_formula_asst_entity_values: { present_cond: false }
  end
end
