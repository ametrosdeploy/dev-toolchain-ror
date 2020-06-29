class CreateFollowUpQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_up_questions do |t|
      t.references :dialogic_assmnt_item, null: false, foreign_key: true
      t.text :question
      t.float :points

      t.timestamps
    end
  end
end
