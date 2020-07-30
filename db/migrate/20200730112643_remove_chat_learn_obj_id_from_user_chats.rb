class RemoveChatLearnObjIdFromUserChats < ActiveRecord::Migration[6.0]
  def change

    remove_column :user_chats, :chat_learn_obj_id, :integer
  end
end
