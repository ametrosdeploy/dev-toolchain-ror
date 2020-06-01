# frozen_string_literal: true

class CreateNumericAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :numeric_answers do |t|
      t.float :answer
      t.references :quiz_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
