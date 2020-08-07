# == Schema Information
#
# Table name: user_chat_messages
#
#  id                               :bigint           not null, primary key
#  message                          :text
#  user_chat_id                     :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  learner_id                       :integer
#  response_to_user_chat_message_id :integer
#  response_result_json             :json
#  assistant_response               :boolean          default(FALSE), not null
#  mentor_response                  :boolean          default(FALSE), not null
#
class UserChatMessage < ApplicationRecord
    belongs_to  :user_chat

    def response_from_watson
        UserChatMessage.where(response_to_user_chat_message_id: self.id, user_chat_id: self.user_chat_id).last
    end
end
