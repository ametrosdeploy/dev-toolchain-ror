class AddFromIdealInputToNluEmotionScore < ActiveRecord::Migration[6.0]
  def change
    add_column :nlu_emotion_scores, :from_ideal_input, :boolean
  end
end
