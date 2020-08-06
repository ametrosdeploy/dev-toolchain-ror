# == Schema Information
#
# Table name: assessment_formula_sentiments
#
#  id                    :bigint           not null, primary key
#  sentiment             :integer
#  comparator            :integer
#  score                 :float
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  range_value           :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class AssessmentFormulaSentiment < ApplicationRecord
   # Associations ...
   belongs_to :assessment_formula

   # Enum ...
   enum sentiment: %i[positive negative]
   enum comparator: %i[lt gt range]
 
   # Scopes ...
   scope :to_be_present, -> { where(present_cond: true) }
   scope :to_be_absent, -> { where(present_cond: false) }
end
