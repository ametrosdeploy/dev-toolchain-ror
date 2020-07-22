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
#
class TestChatResponse < ApplicationRecord
end
