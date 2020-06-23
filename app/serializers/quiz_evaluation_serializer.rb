# frozen_string_literal: true

# Quiz Evaluation Serializer ...
class QuizEvaluationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_learn_obj_id, :quiz_submitted,
             :evaluated, :point_type, :points

  attribute :quiz_responses do |evaluation|
    QuizResponseSerializer.new(evaluation.quiz_responses)
                          .as_json['data']
  end

  attribute :overall_assmnt_item do |evaluation|
    OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
                               .as_json['data']
  end
end
