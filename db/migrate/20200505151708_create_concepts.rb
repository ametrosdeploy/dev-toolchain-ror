class CreateConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :concepts do |t|
      t.string :label
      t.text :synonyms, array: true, default: []
      t.integer :relevance, default: 0
      t.boolean :mandatory, default: false
      t.references :conceptable, polymorphic: true

      t.timestamps
    end
  end
end
