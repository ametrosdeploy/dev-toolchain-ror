class CreateFormulaAsstEntityValues < ActiveRecord::Migration[6.0]
  def change
    create_table :formula_asst_entity_values do |t|
      t.references :asst_entity_value, null: false, foreign_key: true
      t.references :response_formula, null: false, foreign_key: true
      t.boolean :present_cond

      t.timestamps
    end
  end
end
