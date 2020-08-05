class AddUserChatMessageIdToChatEvaluationSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_evaluation_skills, :user_chat_message_id, :bigint
  end
end
