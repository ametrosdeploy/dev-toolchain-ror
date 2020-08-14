# frozen_string_literal: true

module Learner
  # Dialogic debrief serializer
  class DialogicDebriefEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    attributes :debrief_received, :key_topic_missed, :kt_points,
               :dialogic_question_id

    attribute :assessment_label do |assessment|
      assessment.assessment_label.try(:name)
    end

    attribute :question_concept do |assessment|
      assessment.dialogic_question.try(:concept)
    end

    attribute :assessment_icon_url do |assessment|
      image_url(assessment.assessment_label.try(:icon))
    end

    attribute :topic_name do |assessment|
      assessment.key_topic.try(:asst_entity).try(:name)
    end

    attribute :suggested_contents, if: proc { |assessment|
                                         assessment.adaptive_contents.present?
                                       } do |assessment|
      AdaptiveContentSerializer.new(assessment.adaptive_contents)
                               .as_json['data']
    end
  end
end
