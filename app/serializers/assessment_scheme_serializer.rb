# frozen_string_literal: true

class AssessmentSchemeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :assessment_labels do |scheme|
    AssessmentLabelSerializer.new(scheme.assessment_labels).as_json['data']
  end
end
