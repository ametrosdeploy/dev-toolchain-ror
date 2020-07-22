class AddChatLearnObjIdToTestChats < ActiveRecord::Migration[6.0]
  def change
    add_column :test_chats, :chat_learn_obj_id, :integer
  end
end
