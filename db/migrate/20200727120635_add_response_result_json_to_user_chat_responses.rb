class AddResponseResultJsonToUserChatResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chat_responses, :response_result_json, :json
  end
end
