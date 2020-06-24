# frozen_string_literal: true

module Learner
  # Trimmed Learner Response
  class QuizResponseTrimmedSerializer
    include FastJsonapi::ObjectSerializer
    attributes :evaluated, :quiz_question_id

    attribute :learner_chosed_option, if: proc { |record|
      record.mcq_response_id.present?
    } do |rec|
      McqOptionSerializer.new(rec.mcq_response).as_json['data']
    end

    attribute :learner_answer, if: proc { |record|
      record.mcq_response_id.blank?
    }, &:response
  end
end
