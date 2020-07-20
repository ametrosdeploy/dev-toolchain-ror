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
class ResponseFormulaHit < ApplicationRecord
  # Associations ...
  belongs_to :user_email_evaluation
  belongs_to :response_formula
end
