# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_answers
#
#  id                     :bigint           not null, primary key
#  dialogic_evaluation_id :bigint           not null
#  dialogic_question_id   :bigint           not null
#  answer                 :text
#  evaluated              :boolean          default(FALSE)
#  follow_up_answer       :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class DialogicAnswer < ApplicationRecord
  belongs_to :dialogic_evaluation
  belongs_to :dialogic_question
end
