# frozen_string_literal: true

module Learner
  # Dialogic Answers
  class DialogicAnswerSerializer
    include FastJsonapi::ObjectSerializer
    attributes :dialogic_evaluation_id, :dialogic_question_id, :answer,
               :evaluated, :character_response, :attempt, :follow_up_question

    attribute :question do |dialogic_ans|
      Learner::QuestionVariationSerializer.new(dialogic_ans.question_variation)
                                          .as_json['data']
    end

    attribute :key_topic_evaluations do |ans|
      AnswerKeyTopicEvaluationSerializer.new(ans.answer_key_topic_evaluations)
                                        .as_json['data']
    end
  end
end
