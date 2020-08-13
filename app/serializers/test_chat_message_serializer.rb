# frozen_string_literal: true

# == Schema Information
#
# Table name: test_chat_messages
#
#  id                               :bigint           not null, primary key
#  message                          :text
#  test_chat_id                     :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  mentor_character_id              :integer
#  chat_character_id                :integer
#  response_to_test_chat_message_id :integer
#  response_result_json             :json
#  assistant_response               :boolean          default(FALSE), not null
#
class TestChatMessageSerializer
    include FastJsonapi::ObjectSerializer
    attributes :test_chat_id, :message, :assistant_response, :mentor_character_id, :chat_character_id, :response_to_test_chat_message_id, :response_result_json
    
    attribute :test_chat_watson_response
end

