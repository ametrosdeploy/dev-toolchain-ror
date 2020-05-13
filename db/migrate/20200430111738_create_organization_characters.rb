class CreateOrganizationCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_characters do |t|
      t.references :character, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.references :world_role, null: false, foreign_key: true

      t.timestamps
    end
    add_index :organization_characters, %i[character_id organization_id world_role_id],
              unique: true, name: 'character_id_organization_id_world_role_id'
  end
end
