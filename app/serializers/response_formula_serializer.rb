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
#  sentiment_enabled        :boolean          default(TRUE)
#  emotion_enabled          :boolean          default(TRUE)
#
class ResponseFormulaSerializer
  include FastJsonapi::ObjectSerializer
  attributes :present_cond_keyword_min, :absent_cond_keyword_min,
             :sentiment_enabled, :emotion_enabled

  attribute :email_response, &:email_response

  attribute :formula_nlu_entities, if: proc { |record|
    record.formula_nlu_entities.present?
  } do |formula|
    FormulaNluEntitySerializer.new(formula.formula_nlu_entities)
                              .as_json['data']
  end

  attribute :formula_nlu_keywords, if: proc { |record|
    record.formula_nlu_keywords.present?
  } do |formula|
    FormulaNluKeywordSerializer.new(formula.formula_nlu_keywords)
                               .as_json['data']
  end

  attribute :formula_nlu_concepts, if: proc { |record|
    record.formula_nlu_concepts.present?
  } do |formula|
    FormulaNluConceptSerializer.new(formula.formula_nlu_concepts)
                               .as_json['data']
  end

  attribute :formula_asst_intents, if: proc { |record|
    record.formula_asst_intents.present?
  } do |formula|
    FormulaAsstIntentSerializer.new(formula.formula_asst_intents)
                               .as_json['data']
  end

  attribute :formula_asst_entity_values, if: proc { |record|
    record.formula_asst_entity_values.present?
  } do |formula|
    FormulaAsstEntityValueSerializer.new(formula.formula_asst_entity_values)
                                    .as_json['data']
  end

  attribute :formula_emotions, if: proc { |record|
    record.formula_emotions.present?
  } do |formula|
    FormulaEmotionSerializer.new(formula.formula_emotions)
                            .as_json['data']
  end

  attribute :formula_sentiments, if: proc { |record|
    record.formula_sentiments.present?
  } do |formula|
    FormulaSentimentSerializer.new(formula.formula_sentiments)
                              .as_json['data']
  end
end
