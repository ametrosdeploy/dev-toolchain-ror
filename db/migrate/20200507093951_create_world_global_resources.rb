# frozen_string_literal: true

class CreateWorldGlobalResources < ActiveRecord::Migration[6.0]
  def change
    create_table :world_global_resources do |t|
      t.references :global_resource, null: false, foreign_key: true
      t.references :world, null: false, foreign_key: true

      t.timestamps
    end
  end
end
