class CreateConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :concepts do |t|
      t.string :label
      t.text :synonyms, array: true, default: []
      t.integer :relevance
      t.boolean :mandatory
      t.references :conceptable, polymorphic: true

      t.timestamps
    end
  end
end
