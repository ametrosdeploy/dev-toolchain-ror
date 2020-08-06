# == Schema Information
#
# Table name: assessment_formula_nlu_keywords
#
#  id                    :bigint           not null, primary key
#  nlu_keyword_id        :bigint
#  assessment_formula_id :bigint
#  present_cond          :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe AssessmentFormulaNluKeyword, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
