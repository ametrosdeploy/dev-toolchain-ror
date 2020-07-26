# frozen_string_literal: true

# == Schema Information
#
# Table name: test_chat_messages
#
#  id           :bigint           not null, primary key
#  test_message :text
#  test_chat_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class TestChatMessagesSerializer
    include FastJsonapi::ObjectSerializer
    attributes :test_chat_id, :test_message

    attribute :character_response do |item|
        TestChatResponseSerializer.new(item.test_chat_response)
                                .as_json['data']
    end
    
end

