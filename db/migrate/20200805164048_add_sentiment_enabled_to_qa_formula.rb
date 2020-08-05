class AddSentimentEnabledToQaFormula < ActiveRecord::Migration[6.0]
  def change
    add_column :qa_formulas, :sentiment_enabled, :boolean, default: true
    add_column :qa_formulas, :emotion_enabled, :boolean, default: true
  end
end
