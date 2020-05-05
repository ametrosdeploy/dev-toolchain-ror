class CreateEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :entities do |t|
      t.string :label
      t.text :synonyms, array: true, default: []
      t.integer :relevance, default: 0
      t.boolean :mandatory, default: false
      t.references :entitable, polymorphic: true

      t.timestamps
    end
  end
end
