class CreateResponseFormulaItems < ActiveRecord::Migration[6.0]
  def change
    create_table :response_formula_items do |t|
      t.references :response_formula, null: false, foreign_key: true
      t.references :enrichment_item, polymorphic: true, null: false, index: { name: :enrichment_item_index }

      t.timestamps
    end
  end
end
