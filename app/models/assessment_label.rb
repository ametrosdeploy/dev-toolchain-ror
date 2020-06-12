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
class AssessmentLabel < ApplicationRecord
  # Validations ...
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :assessment_scheme_id
  
  # Associations ...
  belongs_to :assessment_scheme
  has_one_attached :icon
end
