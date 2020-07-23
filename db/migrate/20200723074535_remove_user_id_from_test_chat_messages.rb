class RemoveUserIdFromTestChatMessages < ActiveRecord::Migration[6.0]
  def change

    remove_column :test_chat_messages, :user_id, :integer
  end
end
