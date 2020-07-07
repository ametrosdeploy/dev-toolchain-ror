class CreateChatSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_skills do |t|
      t.integer :assistant_dialog_skill_id
      t.string :skill_name

      t.timestamps
    end
    add_index :chat_skills, :assistant_dialog_skill_id
  end
end
