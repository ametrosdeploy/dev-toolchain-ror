class CreateAssessmentFormulaHits < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_formula_hits do |t|
      t.bigint :user_email_evaluation_id
      t.bigint :assessment_formula_id

      t.timestamps
    end
  end
end
