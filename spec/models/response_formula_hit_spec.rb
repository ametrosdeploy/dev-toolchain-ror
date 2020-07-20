# frozen_string_literal: true

# == Schema Information
#
# Table name: response_formula_hits
#
#  id                       :bigint           not null, primary key
#  user_email_evaluation_id :bigint           not null
#  response_formula_id      :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'rails_helper'

RSpec.describe ResponseFormulaHit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
