class AddWorldRoleReferenceOnWorldOrgCharacters < ActiveRecord::Migration[6.0]
  def change
    add_reference :world_org_characters, :world_role, foreign_key: true, index: true, null: false
    change_column :world_roles, :name, :string, null: false
  end
end
