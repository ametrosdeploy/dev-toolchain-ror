class CreateAsstEntityValues < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_entity_values do |t|
      t.string :value
      t.references :asst_entity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
