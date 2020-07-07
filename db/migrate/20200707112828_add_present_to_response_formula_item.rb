class AddPresentToResponseFormulaItem < ActiveRecord::Migration[6.0]
  def change
    add_column :response_formula_items, :present, :boolean, default: true
  end
end
