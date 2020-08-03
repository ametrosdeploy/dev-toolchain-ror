class SentimentEmotionFieldsToResponseFormula < ActiveRecord::Migration[6.0]
  def change
    add_column :response_formulas, :sentiment_enabled, :boolean, default: true
    add_column :response_formulas, :emotion_enabled, :boolean, default: true
  end
end
