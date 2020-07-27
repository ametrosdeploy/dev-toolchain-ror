class AddChatLearnObjToUserChats < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chats, :chat_learn_obj_id, :integer
  end
end
