class RemoveFromIdealInputFromNluEmotionScore < ActiveRecord::Migration[6.0]
  def change
    remove_column :nlu_emotion_scores, :from_ideal_input, :boolean
    remove_column :nlu_sentiments, :from_ideal_input, :boolean

  end
end
