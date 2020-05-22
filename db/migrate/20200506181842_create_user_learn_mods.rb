# frozen_string_literal: true

class CreateUserLearnMods < ActiveRecord::Migration[6.0]
  def change
    create_table :user_learn_mods do |t|
      t.references :user, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true
      t.references :learn_mod, null: false, foreign_key: true
      t.datetime :time_started
      t.datetime :time_completed

      t.timestamps
    end
  end
end
