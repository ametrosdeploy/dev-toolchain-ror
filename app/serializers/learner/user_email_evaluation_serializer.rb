# frozen_string_literal: true

module Learner
  class UserEmailEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    

    attribute :user_email_iterations do |eval|
      UserEmailIterationSerializer.new(eval.user_email_iterations).as_json['data']
    end
  end
end
