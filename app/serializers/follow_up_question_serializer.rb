# frozen_string_literal: true

# == Schema Information
#
# Table name: follow_up_questions
#
#  id                  :bigint           not null, primary key
#  question            :text
#  points              :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  follow_up_able_type :string
#  follow_up_able_id   :bigint
#
class FollowUpQuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :question, :points
end
