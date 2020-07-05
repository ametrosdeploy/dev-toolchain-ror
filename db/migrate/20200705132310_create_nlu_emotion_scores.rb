class CreateNluEmotionScores < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_emotion_scores do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.float :sadness
      t.float :joy
      t.float :fear
      t.float :disgust
      t.float :anger

      t.timestamps
    end
  end
end
