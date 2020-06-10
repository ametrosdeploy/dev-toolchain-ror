# frozen_string_literal: true

class AssessmentLabelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :order
end
