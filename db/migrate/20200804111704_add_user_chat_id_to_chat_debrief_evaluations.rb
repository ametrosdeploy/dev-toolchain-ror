class AddUserChatIdToChatDebriefEvaluations < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_debrief_evaluations, :user_chat_id, :bigint
  end
end
