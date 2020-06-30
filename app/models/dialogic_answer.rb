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
#  character_response     :text
#  follow_up_question     :text
#
class DialogicAnswer < ApplicationRecord
  belongs_to :dialogic_evaluation
  belongs_to :dialogic_question
  has_many :answer_key_topic_evaluations
end
