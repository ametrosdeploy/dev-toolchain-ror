class CreateQuizResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_responses do |t|
      t.text :response
      t.integer :mcq_response_id
      t.boolean :evaluated, default: false
      t.boolean :is_correct
      t.float :points_earned
      t.text :feedback_received
      t.references :user_learn_obj, null: false, foreign_key: true
      t.references :quiz_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
