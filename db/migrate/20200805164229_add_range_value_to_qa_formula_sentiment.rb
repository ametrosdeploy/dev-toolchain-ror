class AddRangeValueToQaFormulaSentiment < ActiveRecord::Migration[6.0]
  def change
    add_column :qa_formula_sentiments, :range_value, :float
    add_column :qa_formula_emotions, :range_value, :float
  end
end
