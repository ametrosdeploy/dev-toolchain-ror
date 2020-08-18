class CreateTestEmailQaConditionHits < ActiveRecord::Migration[6.0]
  def change
    create_table :test_email_qa_condition_hits do |t|
      t.references :test_email_iteration, null: false, foreign_key: true
      t.references :qa_condition, null: false, foreign_key: true
      t.integer :qa_formula_hits, array: true, default: []
      t.boolean :blank_response_hit

      t.timestamps
    end
  end
end
