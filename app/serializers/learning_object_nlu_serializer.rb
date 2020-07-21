# frozen_string_literal: true

class LearningObjectNluSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  # NLU items ..

  attribute :nlu_concepts do |learning_object|
    NluConceptSerializer.new(learning_object.reload.nlu_concepts).as_json['data']
  end

  attribute :nlu_keywords do |learning_object|
    NluKeywordSerializer.new(learning_object.nlu_keywords).as_json['data']
  end

  attribute :nlu_entities do |learning_object|
    NluEntitySerializer.new(learning_object.nlu_entities).as_json['data']
  end

  attribute :nlu_emotion do |learning_object|
    NluEmotionScoreSerializer.new(learning_object.nlu_emotion_score).as_json['data']
  end

  attribute :nlu_sentiments do |learning_object|
    NluSentimentSerializer.new(learning_object.nlu_sentiment).as_json['data']
  end

  attribute :nlu_categories do |learning_object|
    NluCategorySerializer.new(learning_object.nlu_categories).as_json['data']
  end

  attribute :nlu_syntaxes do |learning_object|
    NluSyntaxSerializer.new(learning_object.nlu_syntaxes).as_json['data']
  end

  attribute :nlu_semantic_roles do |learning_object|
    NluSemanticRoleSerializer.new(learning_object.nlu_semantic_roles).as_json['data']
  end
end
