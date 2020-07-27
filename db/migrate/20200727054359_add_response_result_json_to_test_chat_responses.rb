class AddResponseResultJsonToTestChatResponses < ActiveRecord::Migration[6.0]
  def change
    add_column :test_chat_responses, :response_result_json, :json
  end
end
