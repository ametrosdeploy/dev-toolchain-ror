# frozen_string_literal: true

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
class UserChatMessageSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_chat_id, :learner_message, :learner_id

    attribute :user_chat_response
end
  
