class AddChatEvaluationIdToChatEvaluationSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_evaluation_skills, :chat_evaluation_id, :bigint
  end
end
