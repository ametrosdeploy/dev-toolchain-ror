class CreateWorldOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :world_organizations do |t|
      t.integer :world_id
      t.integer :organization_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
