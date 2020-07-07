class CreateUserChats < ActiveRecord::Migration[6.0]
  def change
    create_table :user_chats do |t|
      t.integer :user_learn_obj_id
      t.string :assistant_sessionid
      t.text :assistant_session_json

      t.timestamps
    end
    add_index :user_chats, :user_learn_obj_id
  end
end
