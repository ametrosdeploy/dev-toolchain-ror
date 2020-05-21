# frozen_string_literal: true

class CreateUserLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_learn_objs do |t|
      t.references :user_learn_mod, null: false, foreign_key: true
      t.boolean :complete
      t.references :learning_object, null: false, foreign_key: true

      t.timestamps
    end
  end
end
