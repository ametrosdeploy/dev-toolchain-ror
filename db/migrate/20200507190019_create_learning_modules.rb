class CreateLearningModules < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_modules do |t|
      t.string :name
      t.integer :time_to_complete
      t.text :abstract
      t.references :world, null: false, foreign_key: true

      t.timestamps
    end
  end
end
