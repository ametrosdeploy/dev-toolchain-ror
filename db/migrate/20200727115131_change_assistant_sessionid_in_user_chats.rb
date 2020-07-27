class ChangeAssistantSessionidInUserChats < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_chats, :assistant_sessionid, :assistant_session_id
  end
end
