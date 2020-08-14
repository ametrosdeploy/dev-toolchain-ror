# frozen_string_literal: true

module Learner
  class UserEmailEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :email_subject, :qa_condition_hit, :overall_score, :has_max_score

    # attribute :user_email_iterations do |rec|
    #   UserEmailIterationSerializer.new(rec.user_email_iterations).as_json['data']
    # end

    attribute :user_email_assessment_items do |rec|
      assessment = rec.user_email_assessment_items
      Learner::UserEmailAssessmentItemSerializer.new(assessment).as_json['data']
    end
  end
end
