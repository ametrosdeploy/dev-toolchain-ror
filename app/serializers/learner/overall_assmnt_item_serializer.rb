# frozen_string_literal: true

module Learner
  # Learner Overall assessment serializer
  class OverallAssmntItemSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    attributes :min_score, :max_score, :feedback

    attribute :assessment_label do |assessment|
      assessment.assessment_label.name
    end

    attribute :assessment_icon_url do |assessment|
      image_url(assessment.assessment_label.icon)
    end

    attribute :display_feedback do |assessment|
      assessment.learning_object.overall_assessment_required?
    end
    # attribute :learning_object do |assessment|
    #   assessment.learning_object.objectable
    # end
  end
end
