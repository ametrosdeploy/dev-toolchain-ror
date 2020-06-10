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
class AssessmentScheme < ApplicationRecord
  # Validations ...
  validates :name, presence: true
  validates_uniqueness_of :name
end
