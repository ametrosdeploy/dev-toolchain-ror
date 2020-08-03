# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_test_debriefs
#
#  id                  :bigint           not null, primary key
#  dialogic_test_id    :bigint           not null
#  key_topic_id        :bigint           not null
#  assessment_label_id :bigint
#  debrief_received    :text
#  key_topic_missed    :boolean
#  kt_points           :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
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
