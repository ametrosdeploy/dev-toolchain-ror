# frozen_string_literal: true

class CreateLearnModIntroDocs < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_mod_intro_docs do |t|
      t.references :learn_mod, null: false, foreign_key: true
      t.references :global_resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
