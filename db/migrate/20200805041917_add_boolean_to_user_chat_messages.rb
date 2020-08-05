class AddBooleanToUserChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chat_messages, :assistant_response, :boolean, default: false, null: false
  end
end
