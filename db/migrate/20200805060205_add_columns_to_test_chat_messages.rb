class AddColumnsToTestChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :test_chat_messages, :mentor_character_id, :integer
    add_column :test_chat_messages, :chat_character_id, :integer
    add_column :test_chat_messages, :response_to_test_chat_message_id, :integer
    add_column :test_chat_messages, :response_result_json, :json
    add_column :test_chat_messages, :assistant_response, :boolean, default: false, null: false
  end
end
