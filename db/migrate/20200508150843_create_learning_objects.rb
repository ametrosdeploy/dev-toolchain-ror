class CreateLearningObjects < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_objects do |t|
      t.references :learning_module, null: false, foreign_key: true
      t.references :objectable, polymorphic: true
      t.integer :learning_object_type

      t.timestamps
    end
  end
end
