class CreateQaFormulaAsstIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :qa_formula_asst_intents do |t|
      t.references :asst_intent, null: false, foreign_key: true
      t.references :qa_formula, null: false, foreign_key: true
      t.boolean :present_cond, default: true

      t.timestamps
    end
  end
end
