class CreateDialogicTestAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_test_answers do |t|
      t.references :dialogic_question, null: false, foreign_key: true
      t.references :dialogic_test, null: false, foreign_key: true
      t.text :answer
      t.boolean :evaluated, default: false
      t.text :character_response
      t.text :follow_up_question
      t.references :question_variation, null: false, foreign_key: true
      t.integer :attempt

      t.timestamps
    end
  end
end
