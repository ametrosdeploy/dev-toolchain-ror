class AddRangeValueToFormulaEmotion < ActiveRecord::Migration[6.0]
  def change
    add_column :formula_emotions, :range_value, :float
    add_column :formula_sentiments, :range_value, :float
  end
end
