# frozen_string_literal: true

module Learner
  class UserEmailAssessmentItemSerializer
    include FastJsonapi::ObjectSerializer
    attributes :email_skill, :global_skill, :debrief_content, :debrief_variant,
               :debrief_id, :user_email_evaluation_id

    attribute :email_assessment_item do |rec|
      Learner::EmailAssessmentItemSerializer.new(rec.email_assessment_item)
                                            .as_json['data']
    end
  end
end

