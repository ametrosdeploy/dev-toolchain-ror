class CreateQaFormulaNluEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :qa_formula_nlu_entities do |t|
      t.references :nlu_entity, null: false, foreign_key: true
      t.references :qa_formula, null: false, foreign_key: true
      t.boolean :present_cond, default: true

      t.timestamps
    end
  end
end
