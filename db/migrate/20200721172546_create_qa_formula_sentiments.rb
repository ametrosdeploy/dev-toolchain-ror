class CreateQaFormulaSentiments < ActiveRecord::Migration[6.0]
  def change
    create_table :qa_formula_sentiments do |t|
      t.integer :sentiment
      t.integer :comparator
      t.float :score
      t.references :qa_formula, null: false, foreign_key: true
      t.boolean :present_cond, default: true

      t.timestamps
    end
  end
end
