class CreateAssessmentFormulaNluConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_formula_nlu_concepts do |t|
      t.bigint :nlu_concept_id
      t.bigint :assessment_formula_id
      t.boolean :present_cond

      t.timestamps
    end
  end
end
