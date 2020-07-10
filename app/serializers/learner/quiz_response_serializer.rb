# frozen_string_literal: true

module Learner
  # Learner Quiz response
  class QuizResponseSerializer
    include FastJsonapi::ObjectSerializer
    attributes :is_correct, :points_earned, :feedback_received,
               :quiz_question_id, :mcq_response_id

    attribute :question do |res|
      QuizQuestionWithAnswerSerializer.new(res.quiz_question).as_json['data']
    end

    attribute :learner_answer, if: proc { |record|
      record.mcq_response_id.blank?
    }, &:response

    attribute :learner_chosed_option, if: proc { |record|
      record.mcq_response_id.present?
    } do |res|
      Learner::McqOptionDetailSerializer.new(res.mcq_response).as_json['data']
    end
  end
end
