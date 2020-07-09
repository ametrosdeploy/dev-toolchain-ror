# frozen_string_literal: true

module Learner
  # Dialogic debrief serializer
  class DialogicDebriefEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    attributes :debrief_received, :key_topic_missed, :kt_points

    attribute :assessment_label do |assessment|
      assessment.assessment_label.try(:name)
    end

    attribute :assessment_icon_url do |assessment|
      image_url(assessment.assessment_label.try(:icon))
    end

    attribute :topic_name do |assessment|
      assessment.key_topic.try(:asst_entity).try(:name)
    end
  end
end
