class CreateAssessmentFormulaEmotions < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_formula_emotions do |t|
      t.integer :emotion
      t.integer :comparator
      t.float :score
      t.bigint :assessment_formula_id
      t.boolean :present_cond
      t.float :range_value

      t.timestamps
    end
  end
end
