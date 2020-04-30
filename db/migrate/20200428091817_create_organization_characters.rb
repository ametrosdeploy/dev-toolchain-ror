class CreateOrganizationCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_characters do |t|
      t.integer :character_id
      t.integer :organization_id
      t.integer :character_role

      t.timestamps
    end
  end
end
