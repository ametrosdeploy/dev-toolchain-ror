# frozen_string_literal: true

# == Schema Information
#
# Table name: follow_up_questions
#
#  id                      :bigint           not null, primary key
#  dialogic_assmnt_item_id :bigint           not null
#  question                :text
#  points                  :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class FollowUpQuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :question, :points
end
