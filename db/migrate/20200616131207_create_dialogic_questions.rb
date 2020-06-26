class CreateDialogicQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_questions do |t|
      t.string :concept
      t.text :question
      t.integer :order
      t.references :dialogic_learn_obj, null: false, foreign_key: true

      t.timestamps
    end
  end
end
