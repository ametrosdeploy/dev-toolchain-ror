class AddColumnOrganizationsCountToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :organizations_count, :integer, default: 0
    change_column :worlds, :learn_mods_count, :integer, default: 0
  end
end
