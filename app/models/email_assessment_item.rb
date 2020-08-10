# == Schema Information
#
# Table name: email_assessment_items
#
#  id                  :bigint           not null, primary key
#  email_skill_id      :integer
#  assessment_label_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  points              :integer
#
class EmailAssessmentItem < ApplicationRecord
  # Associations ...
  has_many :assessment_formulas, dependent: :destroy
  belongs_to  :assessment_label

  has_many :debriefs, as: :debriefable
  has_many :adaptive_contents, as: :adaptable, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :assessment_formulas, allow_destroy: true

  accepts_nested_attributes_for :debriefs, allow_destroy: true

  # Methods ...

  def assessment_label_name 
    self.assessment_label.name 
  end 

  def assessment_label_order 
    self.assessment_label.order 
  end
  
end
