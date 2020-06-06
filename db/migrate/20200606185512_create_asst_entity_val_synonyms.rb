class CreateAsstEntityValSynonyms < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_entity_val_synonyms do |t|
      t.string :synonym
      t.references :asst_entity_value, null: false, foreign_key: true

      t.timestamps
    end
  end
end
