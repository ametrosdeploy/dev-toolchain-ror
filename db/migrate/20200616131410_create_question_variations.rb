class CreateQuestionVariations < ActiveRecord::Migration[6.0]
  def change
    create_table :question_variations do |t|
      t.text :question
      t.references :dialogic_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
