# frozen_string_literal: true

# == Schema Information
#
# Table name: assessment_schemes
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AssessmentSchemeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  attribute :assessment_labels do |scheme|
    AssessmentLabelSerializer.new(scheme.assessment_labels).as_json['data']
  end
end
