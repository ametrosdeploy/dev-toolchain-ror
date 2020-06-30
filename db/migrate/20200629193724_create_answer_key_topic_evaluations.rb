class CreateAnswerKeyTopicEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_key_topic_evaluations do |t|
      t.references :dialogic_answer, null: false, foreign_key: true
      t.references :key_topic, null: false, foreign_key: true
      t.references :dialogic_assmnt_item, foreign_key: true
      t.references :missed_assmnt_item, foreign_key: true
      t.float :points_earned

      t.timestamps
    end
  end
end
