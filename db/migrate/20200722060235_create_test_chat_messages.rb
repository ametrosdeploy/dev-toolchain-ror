class CreateTestChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :test_chat_messages do |t|
      t.text :test_message
      t.integer :test_chat_id
      t.integer :user_id

      t.timestamps
    end
  end
end
