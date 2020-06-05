class CreateAsstEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_entities do |t|
      t.string :name
      t.references :entity_addable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
