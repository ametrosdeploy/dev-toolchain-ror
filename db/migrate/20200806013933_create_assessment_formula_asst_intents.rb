class CreateAssessmentFormulaAsstIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_formula_asst_intents do |t|
      t.bigint :asst_intent_id
      t.bigint :assessment_formula_id
      t.boolean :present_cond

      t.timestamps
    end
  end
end
