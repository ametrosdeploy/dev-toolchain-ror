class CreateNluCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_categories do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.string :hierarchy
      t.float :score

      t.timestamps
    end
  end
end
