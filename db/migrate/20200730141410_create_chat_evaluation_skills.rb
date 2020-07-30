class CreateChatEvaluationSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_evaluation_skills do |t|
      t.string :skill_name
      t.integer :skill_value
      t.bigint :user_chat_response_id

      t.timestamps
    end
  end
end
