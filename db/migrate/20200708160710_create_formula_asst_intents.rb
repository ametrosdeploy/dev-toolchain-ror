class CreateFormulaAsstIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :formula_asst_intents do |t|
      t.references :asst_intent, null: false, foreign_key: true
      t.references :response_formula, null: false, foreign_key: true
      t.boolean :present_cond

      t.timestamps
    end
  end
end
