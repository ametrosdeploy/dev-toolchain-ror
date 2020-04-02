class CreateLearnModSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_mod_skills do |t|
      t.references :learn_mod, null: false, foreign_key: true
      t.references :global_skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
