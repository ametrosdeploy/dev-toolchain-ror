class CreateWorldOrgRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :world_org_roles do |t|
      t.references :world_organization, null: false, foreign_key: true
      t.references :WorldRole, null: false, foreign_key: true

      t.timestamps
    end
  end
end
