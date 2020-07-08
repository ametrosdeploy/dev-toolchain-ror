# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_sentiments
#
#  id                  :bigint           not null, primary key
#  sentiment           :integer
#  comparator          :integer
#  score               :float
#  present_cond        :boolean
#  response_formula_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class FormulaSentimentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :sentiment, :comparator, :score, :present_cond
end
