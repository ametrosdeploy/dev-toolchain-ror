class AddResponseToUserChatMessageToUserChatResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chat_responses, :response_to_user_chat_message_id, :integer
  end
end
