# frozen_string_literal: true

class TestEmailEvaluationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :keyword_list, :concept_list, :nlu_entities_list, :asst_intent_list,
             :joy_score, :anger_score, :disgust_score,
             :sadness_score, :fear_score, :sentiment, :sentiment_score

  attribute :asst_entity_value_list do |rec|
    AsstEntityValue.where(id: rec.asst_entity_value_list)&.pluck(:value)
  end
end
