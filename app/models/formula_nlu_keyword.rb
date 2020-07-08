# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_nlu_keywords
#
#  id                  :bigint           not null, primary key
#  nlu_keyword_id      :bigint           not null
#  response_formula_id :bigint           not null
#  present_cond        :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class FormulaNluKeyword < ApplicationRecord
  # Associations ...
  belongs_to :nlu_keyword
  belongs_to :response_formula
end
