class CreateAsstAssistantShells < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_assistant_shells do |t|
      t.integer :assistant_dialog_skill_id
      t.string :name
      t.string :guid
      t.text :url
      t.text :api_key
      t.string :credentials_name

      t.timestamps
    end
    add_index :asst_assistant_shells, :assistant_dialog_skill_id
  end
end
