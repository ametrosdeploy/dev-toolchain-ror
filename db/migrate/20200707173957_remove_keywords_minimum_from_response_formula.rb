class RemoveKeywordsMinimumFromResponseFormula < ActiveRecord::Migration[6.0]
  def change
    remove_column :response_formulas, :keywords_minimum, :integer
    add_column :response_formulas, :present_cond_keyword_min, :integer
    add_column :response_formulas, :absent_cond_keyword_min, :integer
  end
end
