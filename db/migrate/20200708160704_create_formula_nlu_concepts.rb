class CreateFormulaNluConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :formula_nlu_concepts do |t|
      t.references :nlu_concept, null: false, foreign_key: true
      t.references :response_formula, null: false, foreign_key: true
      t.boolean :present_cond

      t.timestamps
    end
  end
end
