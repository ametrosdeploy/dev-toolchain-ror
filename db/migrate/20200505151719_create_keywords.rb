class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.string :label
      t.text :synonyms, array: true, default: []
      t.integer :relevance
      t.boolean :mandatory
      t.references :keywordable, polymorphic: true

      t.timestamps
    end
  end
end
