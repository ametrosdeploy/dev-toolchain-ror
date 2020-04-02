class CreateLearningObjects < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_objects do |t|
      t.string :name
      t.references :learn_mod, null: false, foreign_key: true
      t.int :card_order
      t.int :learning_object_type
      t.references :objectable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
