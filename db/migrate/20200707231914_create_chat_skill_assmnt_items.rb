class CreateChatSkillAssmntItems < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_skill_assmnt_items do |t|
      t.integer :assessment_label_id
      t.integer :value_count_min
      t.integer :value_count_max
      t.float :points
      t.integer :chat_skill_id

      t.timestamps
    end
    add_index :chat_skill_assmnt_items, :assessment_label_id
    add_index :chat_skill_assmnt_items, :chat_skill_id
  end
end
