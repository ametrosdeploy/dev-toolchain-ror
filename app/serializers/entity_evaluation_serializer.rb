# frozen_string_literal: true

class EntityEvaluationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quiz_question_id, :condition
end
