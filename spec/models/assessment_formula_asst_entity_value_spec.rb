# == Schema Information
#
# Table name: assessment_formula_asst_entity_values
#
#  id                    :bigint           not null, primary key
#  asst_entity_value_id  :bigint
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe AssessmentFormulaAsstEntityValue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
