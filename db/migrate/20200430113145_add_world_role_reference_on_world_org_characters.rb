# frozen_string_literal: true

class AddWorldRoleReferenceOnWorldOrgCharacters < ActiveRecord::Migration[6.0]
  def change
    add_reference :world_org_characters, :world_role, foreign_key: true, index: true, null: false
    change_column :world_roles, :name, :string, null: false
    add_index :world_org_characters, %i[character_id world_organization_id world_role_id],
              unique: true, name: 'character_id_world_organization_id_world_role_id'
  end
end
