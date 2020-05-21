# frozen_string_literal: true

class CreateLearnObjCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_obj_characters do |t|
      t.references :world_org_character, null: false, foreign_key: true
      t.integer :character_type
      t.references :learning_object, null: false, foreign_key: true

      t.timestamps
    end
  end
end
