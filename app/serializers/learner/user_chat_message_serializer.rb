# frozen_string_literal: true

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
#  mentor_character_id              :integer
#  chat_character_id                :integer
#  response_to_user_chat_message_id :integer
#  response_result_json             :json
#  assistant_response               :boolean          default(FALSE), not null
#
module Learner
  class UserChatMessageSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_chat_id, :message, :learner_id, :assistant_response,
               :mentor_character_id, :chat_character_id,
               :response_to_user_chat_message_id

    attribute :response_from_watson
  end
end

