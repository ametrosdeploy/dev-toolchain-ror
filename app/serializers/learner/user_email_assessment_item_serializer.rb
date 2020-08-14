# frozen_string_literal: true

module Learner
  class UserEmailAssessmentItemSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    attributes :email_skill, :global_skill, :debrief_content, :debrief_variant,
               :debrief_id, :email_assessment_item, :user_email_evaluation_id

    attribute :assessment_label do |assessment|
      assessment.assessment_label.try(:name)
    end

    attribute :assessment_icon_url do |assessment|
      image_url(assessment.assessment_label.try(:icon))
    end
  end
end

