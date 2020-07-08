# frozen_string_literal: true

# == Schema Information
#
# Table name: question_variations
#
#  id                   :bigint           not null, primary key
#  question             :text
#  dialogic_question_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class QuestionVariation < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_question
  has_one :question_variation
end
