class AddLearnerIdToUserChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chat_messages, :learner_id, :integer
  end
end
