# frozen_string_literal: true

# == Schema Information
#
# Table name: test_chat_responses
#
#  id                               :bigint           not null, primary key
#  assistant_response               :text
#  mentor_character_id              :integer
#  chat_character_id                :integer
#  test_chat_id                     :integer
#  response_to_test_chat_message_id :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  response_result_json             :json
#

class TestChatResponseSerializer
    include FastJsonapi::ObjectSerializer
    attributes :test_chat_id, :assistant_response, :mentor_character_id, :chat_character_id, :response_to_test_chat_message_id, :response_result_json

end

