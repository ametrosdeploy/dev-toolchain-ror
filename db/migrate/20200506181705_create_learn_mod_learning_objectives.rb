class CreateLearnModLearningObjectives < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_mod_learning_objectives do |t|
      t.references :learn_mod, null: false, foreign_key: true
      t.references :learning_objective, null: false, foreign_key: true

      t.timestamps
    end
  end
end
