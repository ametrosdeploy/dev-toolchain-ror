# frozen_string_literal: true

module Learner
  class UserEmailIterationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :email, :iteration, :next_iteration_required

    attribute :responses do |rec|
      UserEmailIterationResponseSerializer.new(rec.user_email_iteration_responses).as_json['data']
    end

    attribute :email_subject do |rec|
      rec.user_email_evaluation.email_subject
    end

    attribute :overall_assmnt_item do |rec|
      Learner::OverallAssmntItemSerializer.new(rec.overall_assmnt_item).as_json['data']
    end

  end
end
