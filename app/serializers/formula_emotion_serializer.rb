# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_emotions
#
#  id                  :bigint           not null, primary key
#  emotion             :integer
#  comparator          :integer
#  score               :float
#  present_cond        :boolean
#  response_formula_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class FormulaEmotionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :emotion, :comparator, :score, :present_cond
end
