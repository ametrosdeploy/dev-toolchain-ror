class AddTestingToUserChats < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chats, :testing, :boolean, default: false, null: false
  end
end
