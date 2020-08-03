# frozen_string_literal: true

# Serializer for Dialogic Test's debrief ...
class DialogicTestDebriefSerializer
  include FastJsonapi::ObjectSerializer
  attributes :debrief_received, :key_topic_missed, :kt_points

  attribute :assessment_label do |assessment|
    assessment.assessment_label.try(:name)
  end

  # attribute :assessment_icon_url do |assessment|
  #   image_url(assessment.assessment_label.try(:icon))
  # end

  attribute :topic_name do |assessment|
    assessment.key_topic.try(:asst_entity).try(:name)
  end
end
