class CreateResponseFormulaHits < ActiveRecord::Migration[6.0]
  def change
    create_table :response_formula_hits do |t|
      t.references :user_email_evaluation, null: false, foreign_key: true
      t.references :response_formula, null: false, foreign_key: true

      t.timestamps
    end
  end
end
