# frozen_string_literal: true

module Learner
  class UserEmailIterationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :email, :iteration

    attribute :responses do |rec|
      UserEmailIterationResponseSerializer.new(rec.user_email_iteration_responses).as_json['data']
    end
  end
end
