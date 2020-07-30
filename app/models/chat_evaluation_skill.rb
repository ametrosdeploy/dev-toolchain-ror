# == Schema Information
#
# Table name: chat_evaluation_skills
#
#  id                    :bigint           not null, primary key
#  skill_name            :string
#  skill_value           :integer
#  user_chat_response_id :bigint
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  chat_evaluation_id    :bigint
#
class ChatEvaluationSkill < ApplicationRecord
    belongs_to  :user_chat_response
    belongs_to  :chat_evaluation
end
