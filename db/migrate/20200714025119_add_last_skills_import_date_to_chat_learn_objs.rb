class AddLastSkillsImportDateToChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_learn_objs, :last_skills_import_date, :datetime
  end
end
