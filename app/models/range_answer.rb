# frozen_string_literal: true

# == Schema Information
#
# Table name: range_answers
#
#  id               :bigint           not null, primary key
#  low_range        :float
#  high_range       :float
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class RangeAnswer < ApplicationRecord
  # Validations ...
  validates :low_range, :high_range, presence: true

  # Assosiations ...
  belongs_to :quiz_question
end
