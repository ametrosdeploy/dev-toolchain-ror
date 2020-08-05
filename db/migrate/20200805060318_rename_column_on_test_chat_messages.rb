class RenameColumnOnTestChatMessages < ActiveRecord::Migration[6.0]
  def change
    rename_column :test_chat_messages, :test_message, :message
  end
end
