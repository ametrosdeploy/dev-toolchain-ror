class CreateFormulaNluKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :formula_nlu_keywords do |t|
      t.references :nlu_keyword, null: false, foreign_key: true
      t.references :response_formula, null: false, foreign_key: true
      t.boolean :present_cond

      t.timestamps
    end
  end
end
