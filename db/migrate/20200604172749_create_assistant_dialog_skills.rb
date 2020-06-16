class CreateAssistantDialogSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :assistant_dialog_skills do |t|
      t.string :name
      t.string :skill_id
      t.references :skillable, polymorphic: true, null: false, index: { name: :skillable_index }

      t.timestamps
    end
  end
end
