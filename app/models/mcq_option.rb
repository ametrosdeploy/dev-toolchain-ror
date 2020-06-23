# frozen_string_literal: true

# == Schema Information
#
# Table name: mcq_options
#
#  id               :bigint           not null, primary key
#  order            :integer
#  option           :text
#  is_correct       :boolean          default(FALSE)
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class McqOption < ApplicationRecord
  # Associations ...
  belongs_to :quiz_question
end
