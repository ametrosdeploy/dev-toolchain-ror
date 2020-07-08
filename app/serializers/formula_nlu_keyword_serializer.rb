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
class FormulaNluKeywordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :present_cond

  attribute :nlu_keyword do |formula|
    formula.nlu_keyword.keyword
  end
end
