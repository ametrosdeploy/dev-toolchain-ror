# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :cutomer_learn_mod, null: false, foreign_key: true

      t.timestamps
    end
  end
end
