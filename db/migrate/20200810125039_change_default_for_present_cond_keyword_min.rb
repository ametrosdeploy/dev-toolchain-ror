class ChangeDefaultForPresentCondKeywordMin < ActiveRecord::Migration[6.0]
  def change
    change_column :response_formulas, :present_cond_keyword_min, :integer, default: 0
    change_column :response_formulas, :absent_cond_keyword_min, :integer, default: 0
  end
end
