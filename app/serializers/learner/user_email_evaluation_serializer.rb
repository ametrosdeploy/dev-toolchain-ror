# frozen_string_literal: true

module Learner
  class UserEmailEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :email_subject, :qa_condition_hit, :overall_score

    attribute :user_email_iterations do |eval|
      UserEmailIterationSerializer.new(eval.user_email_iterations).as_json['data']
    end
  end
end
