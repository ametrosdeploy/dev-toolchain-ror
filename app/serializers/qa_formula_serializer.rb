# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formulas
#
#  id                       :bigint           not null, primary key
#  qa_condition_id          :bigint           not null
#  present_cond_keyword_min :integer          default(0)
#  absent_cond_keyword_min  :integer          default(0)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  sentiment_enabled        :boolean          default(TRUE)
#  emotion_enabled          :boolean          default(TRUE)
#
class QaFormulaSerializer
  include FastJsonapi::ObjectSerializer
  attributes :present_cond_keyword_min, :absent_cond_keyword_min,
             :sentiment_enabled, :emotion_enabled

  attribute :qa_formula_nlu_entities, if: proc { |record|
    record.qa_formula_nlu_entities.present?
  } do |formula|
    FormulaNluEntitySerializer.new(formula.qa_formula_nlu_entities)
                              .as_json['data']
  end

  attribute :qa_formula_nlu_keywords, if: proc { |record|
    record.qa_formula_nlu_keywords.present?
  } do |formula|
    FormulaNluKeywordSerializer.new(formula.qa_formula_nlu_keywords)
                               .as_json['data']
  end

  attribute :qa_formula_nlu_concepts, if: proc { |record|
    record.qa_formula_nlu_concepts.present?
  } do |formula|
    FormulaNluConceptSerializer.new(formula.qa_formula_nlu_concepts)
                               .as_json['data']
  end

  attribute :qa_formula_asst_intents, if: proc { |record|
    record.qa_formula_asst_intents.present?
  } do |formula|
    FormulaAsstIntentSerializer.new(formula.qa_formula_asst_intents)
                               .as_json['data']
  end

  attribute :qa_formula_asst_entity_values, if: proc { |record|
    record.qa_formula_asst_entity_values.present?
  } do |formula|
    FormulaAsstEntityValueSerializer.new(formula.qa_formula_asst_entity_values)
                                    .as_json['data']
  end

  attribute :qa_formula_emotions, if: proc { |record|
    record.qa_formula_emotions.present?
  } do |formula|
    FormulaEmotionSerializer.new(formula.qa_formula_emotions)
                            .as_json['data']
  end

  attribute :qa_formula_sentiments, if: proc { |record|
    record.qa_formula_sentiments.present?
  } do |formula|
    FormulaSentimentSerializer.new(formula.qa_formula_sentiments)
                              .as_json['data']
  end
end
