class RenameLearnerMessageInUserChatMessages < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_chat_messages, :learner_message, :message
  end
end
