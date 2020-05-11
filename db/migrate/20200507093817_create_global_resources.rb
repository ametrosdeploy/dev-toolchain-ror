class CreateGlobalResources < ActiveRecord::Migration[6.0]
  def change
    create_table :global_resources do |t|
      t.string :title
      t.text :description
      t.integer :resource_type
      t.references :customer, null: true, foreign_key: true
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
