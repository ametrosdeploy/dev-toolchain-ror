class CreateFormulaEmotions < ActiveRecord::Migration[6.0]
  def change
    create_table :formula_emotions do |t|
      t.integer :emotion
      t.integer :comparator
      t.float :score
      t.boolean :present_cond
      t.references :response_formula, null: false, foreign_key: true

      t.timestamps
    end
  end
end
