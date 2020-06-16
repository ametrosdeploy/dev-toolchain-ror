# frozen_string_literal: true

class OverallAssmntItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :min_score, :max_score, :feedback

  attribute :assessment_label do |assessment|
    assessment.assessment_label.name
  end

  attribute :learning_object do |assessment|
    assessment.learning_object.objectable
  end
end
