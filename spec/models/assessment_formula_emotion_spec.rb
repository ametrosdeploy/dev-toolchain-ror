# == Schema Information
#
# Table name: assessment_formula_emotions
#
#  id                    :bigint           not null, primary key
#  emotion               :integer
#  comparator            :integer
#  score                 :float
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  range_value           :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe AssessmentFormulaEmotion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
