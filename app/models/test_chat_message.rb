# == Schema Information
#
# Table name: test_chat_messages
#
#  id           :bigint           not null, primary key
#  test_message :text
#  test_chat_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class TestChatMessage < ApplicationRecord
    belongs_to  :test_chat

    def test_chat_response
        TestChatResponse.where(response_to_test_chat_message_id: self.id, test_chat_id: self.test_chat_id).last
    end

    
end