class CreateAssessmentFormulaNluEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_formula_nlu_entities do |t|
      t.bigint :nlu_entity_id
      t.bigint :assessment_formula_id
      t.boolean :present_cond

      t.timestamps
    end
  end
end
