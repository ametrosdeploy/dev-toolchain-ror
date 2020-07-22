class CreateTestChats < ActiveRecord::Migration[6.0]
  def change
    create_table :test_chats do |t|
      t.string :assistant_session_id
      t.jsonb :assistant_session_json
      t.boolean :character_starts_interaction, default: false, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
