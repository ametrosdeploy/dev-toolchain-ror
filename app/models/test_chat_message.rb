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
class TestChatMessage < ApplicationRecord
    belongs_to  :test_chat

    def test_chat_watson_response
        TestChatMessage.where(response_to_test_chat_message_id: self.id, test_chat_id: self.test_chat_id).last
    end

    
end
