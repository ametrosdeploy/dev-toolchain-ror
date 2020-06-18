# frozen_string_literal: true

# == Schema Information
#
# Table name: numeric_answers
#
#  id               :bigint           not null, primary key
#  answer           :float
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class NumericAnswerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :answer
end
