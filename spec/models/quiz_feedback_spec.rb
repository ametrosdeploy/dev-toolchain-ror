# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_feedbacks
#
#  id                 :bigint           not null, primary key
#  right_ans_feedback :text
#  wrong_ans_feedback :text
#  quiz_question_id   :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe QuizFeedback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
