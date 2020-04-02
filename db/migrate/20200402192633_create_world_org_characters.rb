class CreateWorldOrgCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :world_org_characters do |t|
      t.references :world_org_role, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
