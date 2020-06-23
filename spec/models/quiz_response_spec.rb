# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_responses
#
#  id                :bigint           not null, primary key
#  response          :text
#  mcq_response_id   :integer
#  evaluated         :boolean          default(FALSE)
#  is_correct        :boolean
#  points_earned     :float
#  feedback_received :text
#  quiz_question_id  :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe QuizResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
