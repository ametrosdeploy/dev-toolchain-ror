class CreateTestChatResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :test_chat_responses do |t|
      t.text :assistant_response
      t.integer :mentor_character_id
      t.integer :chat_character_id
      t.integer :test_chat_id
      t.integer :response_to_test_chat_message_id

      t.timestamps
    end
  end
end
