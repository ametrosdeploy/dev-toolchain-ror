class CreateNluEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_entities do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.string :entity
      t.string :entity_type
      t.float :score

      t.timestamps
    end
  end
end
