# frozen_string_literal: true

module Learner
  # Dialogic Answers
  class DialogicAnswerSerializer
    include FastJsonapi::ObjectSerializer
    attributes :dialogic_evaluation_id, :dialogic_question_id, :answer,
               :evaluated, :follow_up_answer, :character_response,
               :follow_up_question

    attribute :question do |learn_obj|
      DialogicQuestionsSerializer.new(learn_obj.dialogic_question)
                                 .as_json['data']
    end

    attribute :key_topic_evaluations do |ans|
      AnswerKeyTopicEvaluationSerializer.new(ans.answer_key_topic_evaluations)
                                        .as_json['data']
    end
  end
end
