# frozen_string_literal: true

class DialogicTestAnswerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :dialogic_question_id, :dialogic_test_id,
             :answer, :evaluated, :character_response,
             :follow_up_question, :attempt

  attribute :question do |dialogic_ans|
    Learner::QuestionVariationSerializer.new(dialogic_ans.question_variation)
                                        .as_json['data']
  end

  attribute :key_topic_evaluations do |ans|
    DialogicTestKtEvalSerializer.new(ans.dialogic_test_kt_evals)
                                .as_json['data']
  end
end
