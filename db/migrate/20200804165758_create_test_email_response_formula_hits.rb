class CreateTestEmailResponseFormulaHits < ActiveRecord::Migration[6.0]
  def change
    create_table :test_email_response_formula_hits do |t|
      t.references :test_email_evaluation, null: false, foreign_key: true, index: { name: :test_email_evaluation_index }
      t.references :response_formula, null: false, foreign_key: true

      t.timestamps
    end
  end
end
