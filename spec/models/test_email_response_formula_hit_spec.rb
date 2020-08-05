# == Schema Information
#
# Table name: test_email_response_formula_hits
#
#  id                       :bigint           not null, primary key
#  test_email_evaluation_id :bigint           not null
#  response_formula_id      :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'rails_helper'

RSpec.describe TestEmailResponseFormulaHit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
