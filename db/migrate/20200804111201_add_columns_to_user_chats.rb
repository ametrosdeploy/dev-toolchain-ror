class AddColumnsToUserChats < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chats, :overall_assmnt_item_id, :bigint
    add_column :user_chats, :complete, :boolean, default: false, null: false
    add_column :user_chats, :skills_score_hash, :text
    add_column :user_chats, :skills_missed, :text
  end
end
