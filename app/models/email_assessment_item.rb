# == Schema Information
#
# Table name: email_assessment_items
#
#  id                  :bigint           not null, primary key
#  email_skill_id      :integer
#  assessment_label_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class EmailAssessmentItem < ApplicationRecord
  # Associations ...
  has_many :assessment_formulas, dependent: :destroy

  has_many :debriefs, as: :debriefable
  has_many :adaptive_contents, as: :adaptable, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :assessment_formulas, allow_destroy: true

  # Methods ...
  
end
