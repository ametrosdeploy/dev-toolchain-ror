# == Schema Information
#
# Table name: user_chat_responses
#
#  id                               :bigint           not null, primary key
#  assistant_response               :text
#  mentor_character_id              :integer
#  chat_character_id                :integer
#  user_chat_id                     :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  response_to_user_chat_message_id :integer
#  response_result_json             :json
#
class UserChatResponse < ApplicationRecord
    belongs_to  :user_chat
    has_many    :chat_evaluation_skills
end
