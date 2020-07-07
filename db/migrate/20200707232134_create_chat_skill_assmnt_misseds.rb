class CreateChatSkillAssmntMisseds < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_skill_assmnt_misseds do |t|
      t.integer :chat_skill_id
      t.float :points

      t.timestamps
    end
    add_index :chat_skill_assmnt_misseds, :chat_skill_id
  end
end
