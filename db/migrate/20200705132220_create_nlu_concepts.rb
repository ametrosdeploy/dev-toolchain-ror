class CreateNluConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_concepts do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.string :concept
      t.float :score

      t.timestamps
    end
  end
end
