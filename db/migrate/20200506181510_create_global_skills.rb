# frozen_string_literal: true

class CreateGlobalSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :global_skills do |t|
      t.string :name

      t.timestamps
    end
  end
end
