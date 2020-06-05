class CreateAsstEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_entities do |t|
      t.string :name
      t.references :entity_addable, polymorphic: true, null: false, index: { name: :entity_addable_index }

      t.timestamps
    end
  end
end
