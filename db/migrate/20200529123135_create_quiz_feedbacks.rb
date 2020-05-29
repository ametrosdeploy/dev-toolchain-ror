class CreateQuizFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_feedbacks do |t|
      t.text :right_ans_feedback
      t.text :wrong_ans_feedback
      t.references :quiz_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
