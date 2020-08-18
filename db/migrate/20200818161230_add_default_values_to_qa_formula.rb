class AddDefaultValuesToQaFormula < ActiveRecord::Migration[6.0]
  def change
    change_column :qa_formulas, :present_cond_keyword_min, :integer, default: 0
    change_column :qa_formulas, :absent_cond_keyword_min, :integer, default: 0
  end
end
