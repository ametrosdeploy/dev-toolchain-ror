class RemoveTestingFromUserChats < ActiveRecord::Migration[6.0]
  def change

    remove_column :user_chats, :testing, :boolean
  end
end
