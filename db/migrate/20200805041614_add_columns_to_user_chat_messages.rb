class AddColumnsToUserChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chat_messages, :mentor_character_id, :integer
    add_column :user_chat_messages, :chat_character_id, :integer
    add_column :user_chat_messages, :response_to_user_chat_message_id, :integer
    add_column :user_chat_messages, :response_result_json, :json
  end
end
