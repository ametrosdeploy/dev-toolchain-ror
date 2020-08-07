class RemoveColumnsFromUserChatMessages < ActiveRecord::Migration[6.0]
  def change

    remove_column :user_chat_messages, :mentor_character_id, :integer

    remove_column :user_chat_messages, :chat_character_id, :integer
  end
end
