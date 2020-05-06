class CreateCutomerLearnMods < ActiveRecord::Migration[6.0]
  def change
    create_table :cutomer_learn_mods do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :learn_mod, null: false, foreign_key: true
      t.boolean :detached

      t.timestamps
    end
  end
end
