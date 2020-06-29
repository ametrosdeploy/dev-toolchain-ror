class CreateDialogicAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_answers do |t|
      t.references :dialogic_evaluation, null: false, foreign_key: true
      t.references :dialogic_question, null: false, foreign_key: true
      t.text :answer
      t.boolean :evaluated, default: false
      t.boolean :follow_up_answer, default: false

      t.timestamps
    end
  end
end
