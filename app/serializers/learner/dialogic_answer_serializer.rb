# frozen_string_literal: true

class DialogicAnswerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :dialogic_evaluation_id, :dialogic_question_id, 
             :dialogic_question_id, :answer, :evaluated,
             :follow_up_answer
end
