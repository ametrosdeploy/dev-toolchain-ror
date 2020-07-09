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
  belongs_to :question_variation
  has_many :answer_key_topic_evaluations

  validates_presence_of :question_variation_id

  validates_uniqueness_of :dialogic_question_id,
                          scope: %i[dialogic_evaluation_id follow_up_answer],
                          message: I18n.t(:dialogic_ans_prevent)
end
