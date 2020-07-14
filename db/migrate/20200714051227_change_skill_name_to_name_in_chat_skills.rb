class ChangeSkillNameToNameInChatSkills < ActiveRecord::Migration[6.0]
  def change
    rename_column :chat_skills, :skill_name, :name
  end
end
