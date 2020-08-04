class RemoveChatEvaluationIdFromChatDebriefEvaluations < ActiveRecord::Migration[6.0]
  def change

    remove_column :chat_debrief_evaluations, :chat_evaluation_id, :bigint
  end
end
