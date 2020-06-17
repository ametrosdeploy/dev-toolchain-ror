# frozen_string_literal: true

class CreateQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_questions do |t|
      t.text :question
      t.integer :question_type
      t.integer :points
      t.integer :order
      t.boolean :feedback_from_watson, default: false
      t.references :quiz_learn_obj, null: false, foreign_key: true

      t.timestamps
    end
  end
end
