class CreateQaConditionHits < ActiveRecord::Migration[6.0]
  def change
    create_table :qa_condition_hits do |t|
      t.references :user_email_iteration, null: false, foreign_key: true
      t.references :qa_condition, null: false, foreign_key: true
      t.integer :qa_formula_hits, array: true, default: []
      t.boolean :blank_response_hit

      t.timestamps
    end
  end
end
