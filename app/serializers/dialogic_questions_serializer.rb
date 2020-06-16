# frozen_string_literal: true

class DialogicQuestionsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :order, :concept, :question

  attribute :variations do |qn|
    QuestionVariationSerializer.new(qn.question_variations).as_json['data']
  end
end
