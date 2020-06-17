# frozen_string_literal: true

# == Schema Information
#
# Table name: assessment_labels
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  order                :integer
#  assessment_scheme_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class AssessmentLabelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :order
end
