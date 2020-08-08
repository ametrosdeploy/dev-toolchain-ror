# == Schema Information
#
# Table name: assessment_formula_hits
#
#  id                       :bigint           not null, primary key
#  user_email_evaluation_id :bigint
#  assessment_formula_id    :bigint
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'rails_helper'

RSpec.describe AssessmentFormulaHit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
