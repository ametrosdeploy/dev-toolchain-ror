class CreateEntityEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :entity_evaluations do |t|
      t.text :condition
      t.references :quiz_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
