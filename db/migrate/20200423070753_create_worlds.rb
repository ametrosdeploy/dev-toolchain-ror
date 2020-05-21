# frozen_string_literal: true

class CreateWorlds < ActiveRecord::Migration[6.0]
  def change
    create_table :worlds do |t|
      t.string :name, null: false
      t.text :description
      t.integer :world_code, null: false
      t.boolean :is_private
      t.integer :learn_mods_count

      t.timestamps
    end
    add_index :worlds, :world_code, unique: true
  end
end
