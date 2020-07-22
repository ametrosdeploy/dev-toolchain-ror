class RemoveAssistantResponseFromUserChatMessages < ActiveRecord::Migration[6.0]
  def change

    remove_column :user_chat_messages, :assistant_response, :text
    remove_column :user_chat_messages, :mentor, :boolean 
    
  end
end
