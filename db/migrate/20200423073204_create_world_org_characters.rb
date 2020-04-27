class CreateWorldOrgCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :world_org_characters do |t|
      t.integer :character_id
      t.integer :world_organization_id
      t.integer :character_role

      t.timestamps
    end
  end
end
