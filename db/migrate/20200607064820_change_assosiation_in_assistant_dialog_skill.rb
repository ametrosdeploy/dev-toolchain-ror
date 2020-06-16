class ChangeAssosiationInAssistantDialogSkill < ActiveRecord::Migration[6.0]
  def change
    remove_column :assistant_dialog_skills, :skillable_type
    remove_column :assistant_dialog_skills, :skillable_id
    add_reference :assistant_dialog_skills, :learning_object, index: true
  end
end
