# frozen_string_literal: true

class DialogicQuestionsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :order, :concept, :question

  attribute :variations do |qn|
    QuestionVariationSerializer.new(qn.question_variations).as_json['data']
  end

  attribute :key_topics do |qn|
    KeyTopicSerializer.new(qn.key_topics).as_json['data']
  end
end
