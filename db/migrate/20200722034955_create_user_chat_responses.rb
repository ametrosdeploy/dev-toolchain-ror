class CreateUserChatResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_chat_responses do |t|
      t.text :assistant_response
      t.integer :mentor_character_id
      t.integer :chat_character_id
      t.integer :user_chat_id

      t.timestamps
    end
    add_index :user_chat_responses, :user_chat_id
  end
end
