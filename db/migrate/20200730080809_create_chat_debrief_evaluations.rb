class CreateChatDebriefEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_debrief_evaluations do |t|
      t.bigint :chat_evaluation_id
      t.bigint :assessment_label_id
      t.bigint :chat_skill_assmnt_item_id
      t.bigint :chat_skill_assmnt_missed_id
      t.text :debrief_received
      t.float :assmnt_item_points

      t.timestamps
    end
  end
end
