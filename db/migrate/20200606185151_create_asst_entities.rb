class CreateAsstEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_entities do |t|
      t.string :name
      t.references :learning_object, null: false, foreign_key: true

      t.timestamps
    end
  end
end
