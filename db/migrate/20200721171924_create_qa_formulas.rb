class CreateQaFormulas < ActiveRecord::Migration[6.0]
  def change
    create_table :qa_formulas do |t|
      t.references :qa_condition, null: false, foreign_key: true
      t.integer :present_cond_keyword_min
      t.integer :absent_cond_keyword_min

      t.timestamps
    end
  end
end
