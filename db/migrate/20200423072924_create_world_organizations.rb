class CreateWorldOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :world_organizations do |t|
      t.references :world, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
