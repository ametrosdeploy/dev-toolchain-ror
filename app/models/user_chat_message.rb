# == Schema Information
#
# Table name: user_chat_messages
#
#  id              :bigint           not null, primary key
#  learner_message :text
#  user_chat_id    :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  learner_id      :integer
#
class UserChatMessage < ApplicationRecord
    belongs_to  :user_chat

    def user_chat_response
        UserChatResponse.where(response_to_user_chat_message_id: self.id, user_chat_id: self.user_chat_id).last
    end
end
