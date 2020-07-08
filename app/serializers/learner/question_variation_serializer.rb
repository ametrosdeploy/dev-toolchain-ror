# frozen_string_literal: true

module Learner
  # Learner Question Variation
  class QuestionVariationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :question, :dialogic_question_id
  end
end
