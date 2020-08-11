# frozen_string_literal: true

module Learner
  class UserEmailAssessmentItemSerializer
    include FastJsonapi::ObjectSerializer
    attributes :email_skill, :global_skill, :assessment_label, :debrief_content, :debrief_variant, :debrief_id, :email_assessment_item, :user_email_evaluation_id

  end
end

