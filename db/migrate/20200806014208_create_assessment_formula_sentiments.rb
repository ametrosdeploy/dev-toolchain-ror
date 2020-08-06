class CreateAssessmentFormulaSentiments < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_formula_sentiments do |t|
      t.integer :sentiment
      t.integer :comparator
      t.float :score
      t.bigint :assessment_formula_id
      t.boolean :present_cond
      t.float :range_value

      t.timestamps
    end
  end
end
